//
//  APIKeyManager.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Foundation

/// この階層にあるAPIKey.plistに記載したAPIKeyを管理する
struct APIKeyManager {
    enum APIKeyError: Error {
        case NotFound
    }

    private let keyFilePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")

    private func getKeys() -> NSDictionary? {
        guard let keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }

    func getAPIKey(keyName: String) -> String {
        guard let keys = getKeys() else {
            print("APIKeyを読み込めませんでした")
            return ""
        }

        return keys[keyName] as! String
    }
}
