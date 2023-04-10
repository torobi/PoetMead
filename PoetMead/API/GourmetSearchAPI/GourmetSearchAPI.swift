//
//  GourmetSearchAPI.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Alamofire
import Foundation

protocol GourmetSearchAPIProtocol {
    func searchRestaurant(latitude: Double,
                          longitude: Double,
                          range: Int,
                          genre: GourmetGenre,
                          completionHandler: @escaping (Result<SearchResult, AFError>) -> Void)
}

/// APIで定義されているジャンルコード
private enum APIGourmeGenre: String {
    case pub = "G001"
    case diningBar_bal = "G002"
    case creative = "G003"
    case japanese = "G004"
    case western = "G005"
    case italian_french = "G006"
    case chinese = "G007"
    case grilledBeef = "G008"
    case asia_ethnic = "G009"
    case international = "G010"
    case karaoke_party = "G011"
    case bar_cocktail = "G012"
    case ramen = "G013"
    case cafe_sweets = "G014"
    case others = "G015"
    case okonomiyaki_monja = "G016"
    case korean = "G017"
}

/// 検索ジャンル
enum GourmetGenre: String {
    case restaurant
    case pub
    case sweets
}

class GourmetSearchAPI: GourmetSearchAPIProtocol {
    private let apiKey = APIKeyManager().getAPIKey(keyName: "gourmetSearchApiKey")
    private let baseUrl: String = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"

    /// 店舗を検索する
    /// - parameter latitude: 検索範囲の中心の緯度
    /// - parameter longitude: 検索範囲の中心の経度
    /// - parameter range: 検索範囲(m)
    /// - parameter genre: 検索ジャンル
    /// - parameter completionHandler: 検索完了/失敗時に実行するコールバック
    func searchRestaurant(latitude: Double,
                          longitude: Double,
                          range: Int,
                          genre: GourmetGenre,
                          completionHandler: @escaping (Result<SearchResult, AFError>) -> Void) {
        let parameters = ["key": self.apiKey,
                          "format": "json",
                          "lat": latitude,
                          "lng": longitude,
                          "range": rangeValueToQueryStr(range),
                          "genre": genreParam(genre)
                         ] as [String: Any]
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        AF.request(baseUrl, method: .get, parameters: parameters)
            .responseDecodable(of: SearchResults.self, decoder: decoder) { response in
                switch response.result {
                case .success:
                    if let searchResults = response.value {
                        completionHandler(.success(searchResults.results))
                    } else {
                        print("results is nil")
                        completionHandler(.failure(.responseValidationFailed(reason: .dataFileNil)))
                    }
                case .failure(let error):
                    print(error)
                    completionHandler(.failure(error))
                }
            }
    }

    /// 検索ジャンルを元にジャンル指定部分のURLパラメータを生成
    private func genreParam(_ genre: GourmetGenre) -> String {
        switch genre {
        case .restaurant:
            return apiGourmeGenresToQueryStr([
                .creative,
                .japanese,
                .western,
                .italian_french,
                .chinese,
                .grilledBeef])
        case .pub:
            return apiGourmeGenresToQueryStr([
                .pub,
                .diningBar_bal,
                .bar_cocktail
            ])
        case .sweets:
            return apiGourmeGenresToQueryStr([
                .cafe_sweets
            ])
        }
    }

    /// 複数のジャンルコードを元にURLパラメータを生成
    private func apiGourmeGenresToQueryStr(_ genres: [APIGourmeGenre]) -> String {
        let strGenres = genres.map { $0.rawValue }
        return strGenres.joined(separator: ",")
    }

    /// 実際の検索範囲(300~3000)の値をURLパラメータの値(1~5)に変換
    private func rangeValueToQueryStr(_ range: Int) -> Int {
        guard let index = searchRange.firstIndex(of: range) else {
            print("No matching range value")
            return 1
        }
        return index + 1
    }
}
