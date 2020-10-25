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
    
    init(sdk: APISDK = NimbleSurveySDK.shared) {
        apiSDK = sdk
        super.init()
    }
    
    override func request() -> Single<[ResponseSurvey]> {
        // TODO: Pagination
        apiSDK.getSurveysList(pageNumber: 1, pageSize: 2)
    }
}
