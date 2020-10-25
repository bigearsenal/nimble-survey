//
//  APISDK.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import RxSwift

protocol APISDK {
    func loginWithEmail(_ email: String, password: String) -> Completable
    func resetPassword(email: String) -> Single<String>
    func getSurveysList(pageNumber: UInt, pageSize: UInt) -> Single<[ResponseSurvey]>
    func getUserProfile() -> Single<ResponseUser>
    func logout() -> Completable
}
