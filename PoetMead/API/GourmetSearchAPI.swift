//
//  GourmetSearchAPI.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Alamofire
import Foundation

class GourmetSearchAPI {
    private let apiKey = APIKeyManager().getAPIKey(keyName: "gourmetSearchApiKey")
    private let baseUrl: String = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"

    private static var task: URLSessionTask?

    enum SearchRestaurantError: Error {
        case wrong
        case network
        case parse
    }

    func searchRestaurant(latitude: Double,
                                 longitude: Double,
                                 range: Int,
                                 completionHandler: @escaping (Result<[SerchResults], SearchRestaurantError>) -> Void) {
        let parameters = ["key": self.apiKey,
                          "format": "json",
                          "lat": latitude,
                          "lng": longitude,
                          "range": range] as [String: Any]
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        AF.request(baseUrl, method: .get, parameters: parameters)
            .responseDecodable(of: SerchResults.self, decoder: decoder) { response in
                switch response.result {
                case .success:
                    if let serchResults = response.value {
                        print("results: \(serchResults)")
                    } else {
                        print("results is nil")
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
