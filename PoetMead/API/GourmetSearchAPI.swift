//
//  GourmetSearchAPI.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import Foundation

class GourmetSearchAPI {
    private var apiKey: String = String()
    private let baseUrl: String = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    private static var task: URLSessionTask?
        
    enum SearchRestaurantError: Error {
        case wrong
        case network
        case parse
    }
    
    static func searchRestaurant(lat: Double, lng: Double, completionHandler: @escaping (Result<[SerchResults], SearchRestaurantError>) -> Void){
        
        
    }
}
