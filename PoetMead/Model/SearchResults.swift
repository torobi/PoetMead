//
//  SearchResults.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Foundation

struct SearchResults: Codable {
    let results: SearchResult
}

struct SearchResult: Codable {
    let resultsAvailable: Int
    let shop: [Shop]
}

struct Shop: Codable {
    let id: String
    let name: String
    let logoImage: String
    let address: String
    let mobileAccess: String
    let `catch`: String
    let open: String
    let photo: Photo
    let lat: Double
    let lng: Double

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
