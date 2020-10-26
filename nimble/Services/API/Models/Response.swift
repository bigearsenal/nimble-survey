//
//  Response.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T?
    let meta: ResponseMeta?
}
struct ResponseData<T: Decodable>: Decodable {
    let id: IntOrString
    let type: String
    let attributes: T
    // TODO: relationships
}

struct ResponseToken: Codable {
    let access_token: String
    let token_type: String
    let expires_in: UInt
    let refresh_token: String
    let created_at: UInt
    
    var isValid: Bool {
        let expiredDate = created_at + expires_in
        return expiredDate > UInt(Date().timeIntervalSince1970)
    }
}

struct ResponseSurvey: Decodable, Equatable {
    let title: String?
    let description: String?
    let thank_email_above_threshold: String?
    let thank_email_below_threshold: String?
    let is_active: Bool?
    let cover_image_url: String?
    let created_at: String?
    let active_at: String?
    let inactive_at: String?
    let survey_type: String?
}

struct ResponseUser: Decodable {
    let email: String?
    let avatar_url: String?
}

// Meta response
struct ResponseMeta: Decodable {
    let message: String?
    let page: UInt?
    let pages: UInt?
    let page_size: UInt?
    let records: UInt?
}

struct ResponseEmpty: Decodable {}

struct IntOrString: Codable, Equatable {
    public let stringValue: String?
    
    // Where we determine what type the value is
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            stringValue = try container.decode(String.self)
        } catch {
            do {
                stringValue = "\(try container.decode(Int.self))"
            } catch {
                stringValue = ""
            }
        }
    }
    
    // We need to go back to a dynamic type, so based on the data we have stored, encode to the proper type
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(stringValue)
    }
    
    public init(string: String?) {
        stringValue = string
    }
}



