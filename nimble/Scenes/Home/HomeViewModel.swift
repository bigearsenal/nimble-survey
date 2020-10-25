//
//  HomeViewModel.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import RxSwift

class HomeViewModel: BaseViewModel<[ResponseSurvey]> {
    let apiSDK: APISDK
    var surveys: Observable<[ResponseSurvey]> {
        dataRelay.filter {$0 != nil}.map {$0!}
    }
    
    init(sdk: APISDK) {
        apiSDK = sdk
        super.init()
    }
    
    override func request() -> Single<[ResponseSurvey]> {
        // TODO: Pagination
        apiSDK.getSurveysList(pageNumber: 1, pageSize: 8)
    }
}
