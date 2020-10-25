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
    
    override func bind() {
        super.bind()
        reloadSubject
            .flatMap {self.apiSDK.getUserProfile()}
            .subscribe(onNext: {self.userRelay.accept($0)})
            .disposed(by: disposeBag)
    }
    
    override func request() -> Single<[ResponseSurvey]> {
        // TODO: Pagination
        apiSDK.getSurveysList(pageNumber: 1, pageSize: 8)
    }
    
    func logOut() {
        // ignore response
        apiSDK.logout().subscribe().disposed(by: disposeBag)
    }
}
