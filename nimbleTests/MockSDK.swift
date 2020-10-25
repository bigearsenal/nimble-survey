//
//  MockAPI.swift
//  nimbleTests
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import RxSwift

struct MockSDK: APISDK {
    static let shared = MockSDK()
    private init() {}
    
    func loginWithEmail(_ email: String, password: String) -> Completable {
        .empty()
    }
    
    func resetPassword(email: String) -> Single<String> {
        .just("")
    }
    
    func getSurveysList(pageNumber: UInt, pageSize: UInt) -> Single<[ResponseSurvey]> {
        do {
            return .just(try getMockList())
        } catch {
            return .error(error)
        }
    }
    
    func getMockList() throws -> [ResponseSurvey] {
        guard let path = Bundle(for: SurveysListDecodingTests.self).path(forResource: "SurveysList", ofType: "json")
        else {
            return []
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let result = try JSONDecoder().decode(Response<[ResponseSurvey]>.self, from: data)
        return result.data ?? []
    }
}
