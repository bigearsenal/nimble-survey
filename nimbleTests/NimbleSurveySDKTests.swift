//
//  nimbleTests.swift
//  nimbleTests
//
//  Created by Chung Tran on 10/21/20.
//

import XCTest
import RxBlocking

class NimbleSurveySDKTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        let loginResult = try NimbleSurveySDK.shared.loginWithEmail("dev@nimblehq.co", password: "12345678").toBlocking().first()
        XCTAssertEqual(loginResult?.token_type, "Bearer")
    }

}
