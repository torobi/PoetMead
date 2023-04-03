//
//  MockGourmetSearchAPI.swift
//  PoetMead
//
//  Created by torobi on 2023/04/03.
//

import Alamofire
import Foundation
class MockGourmetSearchAPI: GourmetSearchAPIProtocol {
    func searchRestaurant(latitude: Double,
                          longitude: Double,
                          range: Int,
                          genre: GourmetGenre,
                          completionHandler: @escaping (Result<SearchResult, AFError>) -> Void) {
        let loadResponseJson = loadResponseJson(forResource: "gourmetSearchResponse")
        completionHandler(.success(loadResponseJson.results))
    }

    private func loadResponseJson(forResource resource: String) -> SearchResults {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let searchResults = try? decoder.decode(SearchResults.self, from: data) else {
            fatalError("JSON読み込みエラー")
        }

        return searchResults
    }
}
