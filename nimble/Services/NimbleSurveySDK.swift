//
//  NimberSurveySDK.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

struct NimbleSurveySDK {
    // MARK: - Properties
    let host: String
    let clientId: String
    let clientSecret: String
    var apiEndpoint: String {
        host + "/api/v1"
    }
    
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
    }
    
    // MARK: - Methods
    func loginWithEmail(_ email: String, password: String) -> Single<ResponseToken> {
        request(
            method: .post,
            path: "/oauth/token",
            parameters: [
                "grant_type": "password",
                "email": email,
                "password": password
            ],
            authorizationRequired: false,
            decodedTo: Response<ResponseToken>.self
        )
        .map {$0.data.attributes}
    }
    
    // MARK: - Helper
    private func apiUrlWithPath(_ path: String) -> String {
        apiEndpoint + path
    }
    
    func request<T: Decodable>(method: HTTPMethod, path: String, parameters: [String: Any]?, authorizationRequired: Bool = true, shouldAddClientInfo: Bool = true, decodedTo: T.Type) -> Single<T>{
        var headers: HTTPHeaders = []
        if authorizationRequired {
            headers = [.authorization(bearerToken: "")]
        }
        var parameters = parameters
        if shouldAddClientInfo {
            parameters?["client_id"] = clientId as NSString
            parameters?["client_secret"] = clientSecret as NSString
        }
        
        return data(method, apiUrlWithPath(path), parameters: parameters, headers: headers)
            .debug()
            .take(1)
            .asSingle()
            .do(onSuccess: { (data) in
                #if DEBUG
                if let string = String(data: data, encoding: .utf8) {
                    print(string)
                }
                #endif
            })
            .map {try JSONDecoder().decode(T.self, from: $0)}
    }
}
