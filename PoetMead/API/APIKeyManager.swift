//
//  APIKeyManager.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Foundation
struct APIKeyManager {
    private let keyFilePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")

    private func getKeys() -> NSDictionary? {
        guard let keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }

    func getAPIKey(keyName: String) -> String? {
        guard let keys = getKeys() else {
            return nil
        }

        return keys[keyName]! as? String
    }
}
