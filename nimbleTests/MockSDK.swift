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
        Completable.empty().delay(.milliseconds(800), scheduler: MainScheduler.instance)
    }
    
    func resetPassword(email: String) -> Single<String> {
        Single<String>.just("").delay(.milliseconds(800), scheduler: MainScheduler.instance)
    }
    
    func getSurveysList(pageNumber: UInt, pageSize: UInt) -> Single<[ResponseSurvey]> {
        do {
            return Single<[ResponseSurvey]>.just(try getMockList()).delay(.milliseconds(800), scheduler: MainScheduler.instance)
        } catch {
            return Single<[ResponseSurvey]>.error(error).delay(.milliseconds(800), scheduler: MainScheduler.instance)
        }
    }
    
    func getMockList() throws -> [ResponseSurvey] {
        guard let path = Bundle(for: HomeViewModelTests.self).path(forResource: "SurveysList", ofType: "json")
        else {
            return []
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let result = try JSONDecoder().decode(Response<[ResponseSurvey]>.self, from: data)
        return result.data ?? []
    }
}
