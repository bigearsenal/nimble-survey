//
//  HomeViewModel.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel<DataType> {
    // MARK: - Nested type
    enum LoadingState: Equatable {
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.loaded, .loaded):
                return true
            case (.error(let err1), .error(let err2)):
                return err1.localizedDescription == err2.localizedDescription
            default:
                return false
            }
        }
        
        case loading
        case loaded
        case error(_ error: Error)
    }
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let reloadSubject = PublishSubject<Void>()
    let loadingStateRelay = BehaviorRelay<LoadingState>(value: .loading)
    let dataRelay = BehaviorRelay<DataType?>(value: nil)
    
    // MARK: - Methods
    init() {
        bind()
    }
    
    func bind() {
        reloadSubject
            .flatMap {_ in self.request()}
            .do(onError: {self.loadingStateRelay.accept(.error($0))},
                onCompleted: {self.loadingStateRelay.accept(.loaded)},
                onSubscribe: {self.loadingStateRelay.accept(.loading)}
            )
            .subscribe { newData in
                self.dataRelay.accept(newData)
            }
            .disposed(by: disposeBag)
    }
    
    func request() -> Single<DataType> {
        fatalError("Must override")
    }
}
