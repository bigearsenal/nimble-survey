//
//  Response.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

extension NimbleSurveySDK {
    struct ResponseNoBody: Decodable {}
    
    // MARK: - ResponseData
    struct ResponseData<T: Decodable>: Decodable {
        let id: Int
        let type: String
        let attributes: T
    }
    
    struct ResponseToken: Decodable {
        let access_token: String
        let token_type: String
        let expires_in: UInt
        let refresh_token: String
        let created_at: UInt
    }
    
    // MARK: - ResponseLogout
    struct ResponseLogout: Decodable {
        
    }
    
    // MARK: - ResponseMeta
    struct ResponseMeta: Decodable {
        
    }
}






