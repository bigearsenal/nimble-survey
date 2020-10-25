//
//  HomeViewModel.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel<[ResponseSurvey]> {
    let apiSDK: APISDK
    let userRelay = BehaviorRelay<ResponseUser?>(value: nil)
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
    
    override func reload() {
        super.reload()
        self.apiSDK.getUserProfile()
            .subscribe(onSuccess: {self.userRelay.accept($0)})
            .disposed(by: disposeBag)
    }
    
    func logOut() {
        // ignore response
        apiSDK.logout().subscribe().disposed(by: disposeBag)
    }
}
