//
//  NimberSurveySDK.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

struct NimbleSurveySDK {
    enum AuthState {
        case authorized, unauthorized
    }
    
    // MARK: - Properties
    let host: String
    let clientId: String
    let clientSecret: String
    var apiEndpoint: String {
        host + "/api/v1"
    }
    let authState: BehaviorRelay<AuthState>
    
    // MARK: - Singleton
    static let shared = NimbleSurveySDK()
    private init() {
        #if DEBUG
        host = "https://survey-api.nimblehq.co"
        clientId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
        clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        #else
        host = "https://survey-api.nimblehq.co"
        clientId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
        clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        #endif
        
        authState = BehaviorRelay<AuthState>(value: KeychainManager.token == nil ? .unauthorized: .authorized)
    }
    
    // MARK: - Methods
    func loginWithEmail(_ email: String, password: String) -> Completable {
        let req = request(
            method: .post,
            path: "/oauth/token",
            parameters: [
                "grant_type": "password",
                "email": email,
                "password": password
            ],
            authorizationRequired: false,
            decodedTo: Response<ResponseToken>.self,
            retryOnTokenExpired: false
        )
        return handleTokenRequest(req)
    }
    
    func resetPassword(email: String) -> Single<String> {
        request(
            method: .post,
            path: "/passwords",
            parameters: [
                "user": [
                    "email": email
                ]
            ],
            authorizationRequired: false,
            decodedTo: Response<ResponseMeta>.self,
            retryOnTokenExpired: false
        )
        .map {$0.meta?.message ?? "If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes."}
    }
    
    // MARK: - Helper
    private func refreshToken() -> Completable {
        let req = request(
            method: .post,
            path: "/oauth/token",
            parameters: [
                "grant_type": "refresh_token",
                "refresh_token": KeychainManager.token?.refresh_token ?? ""
            ],
            authorizationRequired: false,
            decodedTo: Response<ResponseToken>.self,
            retryOnTokenExpired: false
        )
        return handleTokenRequest(req)
    }
    
    private func apiUrlWithPath(_ path: String) -> String {
        apiEndpoint + path
    }
    
    func request<T: Decodable>(
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]?,
        authorizationRequired: Bool = true,
        shouldAddClientInfo: Bool = true,
        decodedTo: T.Type,
        retryOnTokenExpired: Bool = true
    ) -> Single<T>{
        var headers: HTTPHeaders = []
        if authorizationRequired, let token = KeychainManager.token?.access_token {
            headers = [.authorization(bearerToken: token)]
        }
        var parameters = parameters
        if shouldAddClientInfo {
            parameters?["client_id"] = clientId as NSString
            parameters?["client_secret"] = clientSecret as NSString
        }
        
        return RxAlamofire.request(method, apiUrlWithPath(path), parameters: parameters, headers: headers)
            .responseData()
            .map {(response, data) -> T in
                guard (200..<300).contains(response.statusCode) else {
                    // Decode errror
                    throw (try? JSONDecoder().decode(ResponseErrors.self, from: data).errors?.first) ?? .unknown
                }
                
                return try JSONDecoder().decode(T.self, from: data)
            }
            .take(1)
            .asSingle()
            .catchError {
                if let error = $0 as? Error {
                    // Retry
                    if error.code == "invalid_token" && retryOnTokenExpired {
                        return self.refreshToken()
                            .andThen(
                                self.request(
                                    method: method,
                                    path: path,
                                    parameters: parameters,
                                    authorizationRequired: authorizationRequired,
                                    shouldAddClientInfo: shouldAddClientInfo,
                                    decodedTo: decodedTo,
                                    retryOnTokenExpired: false
                                )
                            )
                    }
                }
                throw $0
            }
    }
    
    private func handleTokenRequest(_ request: Single<Response<ResponseToken>>) -> Completable {
        request
            .map { result -> ResponseToken in
                guard let token = result.data?.attributes else {
                    throw Error.unknown
                }
                try KeychainManager.saveToken(token)
                return token
            }
            .do(onSuccess: { _ in
                authState.accept(.authorized)
            })
            .asCompletable()
    }
}
