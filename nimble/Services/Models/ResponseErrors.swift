//
//  ResponseErrors.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

extension NimbleSurveySDK {
    // MARK: - Nested type
    enum Error: Swift.Error {
        case unauthorized(errors: [ResponseError])
    }
    
    struct ResponseErrors: Decodable {
        var errors: [ResponseError]?
    }

    struct ResponseError: Decodable {
        let detail: String?
        let code: String?
        let source: String?
    }
}


