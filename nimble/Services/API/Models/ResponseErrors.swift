//
//  ResponseErrors.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

// MARK: - Nested type
struct ResponseErrors: Decodable {
    var errors: [NBError]?
}

struct NBError: Swift.Error, Decodable {
    let detail: String?
    let code: String?
    let source: String?
    
    static var unknown: NBError {NBError(detail: nil, code: nil, source: nil)}
    
    static var invalidToken: NBError {NBError(detail: "The access token is invalid", code: "invalid_token", source: "unauthorized")}
    
    var localizedDescription: String {(detail ?? "") + (code != nil ? ", code: \(code!)": "")}
}


