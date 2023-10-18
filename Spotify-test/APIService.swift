//
//  APIService.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 17/10/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
}
