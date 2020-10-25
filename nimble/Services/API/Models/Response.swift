//
//  Response.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

extension NimbleSurveySDK {
    struct Response<T: Decodable>: Decodable {
        let data: ResponseData<T>?
        let meta: ResponseMeta?
    }
    struct ResponseData<T: Decodable>: Decodable {
        let id: Int
        let type: String
        let attributes: T
    }
    
    struct ResponseToken: Codable {
        let access_token: String
        let token_type: String
        let expires_in: UInt
        let refresh_token: String
        let created_at: UInt
    }
    
    // Meta response
    struct ResponseMeta: Decodable {
        let message: String
    }
}






