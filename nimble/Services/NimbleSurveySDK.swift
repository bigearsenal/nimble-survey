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
    let clientId: String
    let clientSecret: String
    
    // MARK: - Singleton
    static let shared = NimbleSurveySDK()
    private init() {
        #if DEBUG
        endpoint = "https://nimble-survey-web-staging.herokuapp.com/"
        clientId = ""
        clientSecret = ""
        #else
        endpoint = "https://survey-api.nimblehq.co/"
        clientId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
        clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
        #endif
    }
}
