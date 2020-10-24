//
//  NimberSurveySDK.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

struct NimbleSurveySDK {
    // MARK: - Properties
    let endpoint: String
    
    // MARK: - Singleton
    static let shared = NimbleSurveySDK()
    private init() {
        #if DEBUG
        endpoint = "https://nimble-survey-web-staging.herokuapp.com/"
        #else
        endpoint = "https://survey-api.nimblehq.co/"
        #endif
    }
}
