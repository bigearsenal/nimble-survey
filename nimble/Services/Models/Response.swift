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
    
    // MARK: - ResponseLogout
    struct ResponseLogout: Decodable {
        
    }
    
    // MARK: - ResponseMeta
    struct ResponseMeta: Decodable {
        
    }
}






