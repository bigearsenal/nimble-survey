//
//  HomeViewModelTests.swift
//  nimbleTests
//
//  Created by Chung Tran on 10/25/20.
//

import XCTest

class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testDecodingSurveysList() throws {
        let list = try MockSDK.shared.getMockList()
        XCTAssertEqual(list.count, 2)
    }

    func testHomeViewModel() throws {
        
    }

}
