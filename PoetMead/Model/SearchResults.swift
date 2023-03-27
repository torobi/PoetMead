//
//  SerchResults.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Foundation

struct SerchResults: Codable {
    let results: SerchResult
}

struct SerchResult: Codable {
    let resultsAvailable: Int
    let shop: [Shop]
}

struct Shop: Codable {
    let id: String
    let name: String
    let logoImage: String
    let address: String
    let access: String
    let open: String
    let photo: Photo

    var logoImageUrl: URL? {
        return URL(string: logoImage)
    }
}

struct Photo: Codable {
    struct Mobile: Codable {
        let l: String // swiftlint:disable:this identifier_name
        let s: String // swiftlint:disable:this identifier_name
    }

    private let mobile: Mobile
    var largeImageUrl: URL? {
        return URL(string: mobile.l)
    }
    var smallImageUrl: URL? {
        return URL(string: mobile.s)
    }
}
