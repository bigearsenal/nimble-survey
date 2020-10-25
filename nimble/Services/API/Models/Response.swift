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
    let id: Int
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

// Meta response
struct ResponseMeta: Decodable {
    let message: String?
    let page: UInt?
    let pages: UInt?
    let page_size: UInt?
    let records: UInt?
}






