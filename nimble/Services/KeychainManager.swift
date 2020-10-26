//
//  KeychainManager.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation
import KeychainSwift

struct KeychainManager {
    // MARK: - Constants
    private static let tokenKeychainKey = "_NimbleSurveySDK.ResponseToken"
    
    private static let keychain: KeychainSwift = {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        return keychain
    }()
    
    static var token: ResponseToken? {
        guard let data = keychain.getData(tokenKeychainKey) else {return nil}
        return try? JSONDecoder().decode(ResponseToken.self, from: data)
    }
    
    static func saveToken(_ token: ResponseToken) throws {
        let data = try JSONEncoder().encode(token)
        self.keychain.set(data, forKey: tokenKeychainKey)
    }
    
    static func clear() {
        keychain.clear()
    }
}
