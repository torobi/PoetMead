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

    // MARK: - Detail
    let wifi: String
    let course: String
    let freeDrink: String
    let freeFood: String
    let privateRoom: String
    let card: String
    let nonSmoking: String
    let parking: String
    let barrierFree: String
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

enum ShopDetail: CaseIterable {
    case wifi
    case course
    case freeDrink
    case freeFood
    case privateRoom
    case card
    case nonSmoking
    case parking
    case barrierFree
}
