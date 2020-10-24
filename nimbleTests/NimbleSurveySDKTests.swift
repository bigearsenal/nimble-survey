//
//  nimbleTests.swift
//  nimbleTests
//
//  Created by Chung Tran on 10/21/20.
//

import XCTest

class NimbleSurveySDKTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrors() throws {
        let response = """
        {
            "errors": [
                {
                    "source": "unauthorized",
                    "detail": "The access token is invalid",
                    "code": "invalid_token"
                }
            ]
        }
        """
        let responseErrors = try JSONDecoder().decode(NimbleSurveySDK.ResponseErrors.self, from: response.data(using: .utf8)!)
        XCTAssertEqual(responseErrors.errors?.first?.code, "invalid_token")
    }

}
