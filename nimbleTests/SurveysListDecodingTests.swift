//
//  SurveysListDecodingTests.swift
//  nimbleTests
//
//  Created by Chung Tran on 10/25/20.
//

import XCTest

class SurveysListDecodingTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingSurveysList() throws {
        let list = try MockSDK.shared.getMockList()
        XCTAssertEqual(list.count, 2)
    }

}
