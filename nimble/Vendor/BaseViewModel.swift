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
    let loadingStateRelay = BehaviorRelay<LoadingState>(value: .loading)
    let dataRelay = BehaviorRelay<DataType?>(value: nil)
    
    // MARK: - Methods
    func request() -> Single<DataType> {
        fatalError("Must override")
    }
    
    func reload() {
        self.loadingStateRelay.accept(.loading)
        self.request()
            .subscribe(onSuccess: { newData in
                self.dataRelay.accept(newData)
                self.loadingStateRelay.accept(.loaded)
            }, onError: { (error) in
                self.loadingStateRelay.accept(.error(error))
            })
            .disposed(by: disposeBag)
    }
}
