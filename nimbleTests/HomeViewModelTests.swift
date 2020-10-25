//
//  HomeViewModelTests.swift
//  nimbleTests
//
//  Created by Chung Tran on 10/25/20.
//

import XCTest
import RxTest
import RxSwift

class HomeViewModelTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var mockSDK: MockSDK!
    var mockVM: HomeViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        mockSDK = MockSDK.shared
        mockVM = HomeViewModel(sdk: mockSDK)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testDecodingSurveysList() throws {
        let list = try MockSDK.shared.getMockList()
        XCTAssertEqual(list.count, 2)
    }

//    func testHomeViewModel() throws {
//        // create testable observers
//        let surveys = scheduler.createObserver([ResponseSurvey].self)
//        let loadingState = scheduler.createObserver(HomeViewModel.LoadingState.self)
//        let reloadSubject = scheduler.createObserver(Void.self)
//        
//        mockVM.dataRelay.map {$0 ?? []}
//            .asDriver(onErrorJustReturn: [])
//            .drive(surveys)
//            .disposed(by: disposeBag)
//        
//        mockVM.loadingStateRelay
//            .asDriver()
//            .drive(loadingState)
//            .disposed(by: disposeBag)
//        
//        mockVM.reloadSubject
//            .take(4)
//            .bind(to: reloadSubject)
//            .disposed(by: disposeBag)
//    
//        // when fetching surveys
//        scheduler.createColdObservable([.next(5, ()), .next(10, ()), .next(15, ())])
//            .bind(to: mockVM.reloadSubject)
//            .disposed(by: disposeBag)
//        
//        scheduler.start()
//        
//        XCTAssertEqual(loadingState.events, [.next(0, .loading)])
//    }

}
