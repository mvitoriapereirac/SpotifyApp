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
    
    func createURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/search"
        
        components.queryItems = [
            URLQueryItem(name: "type", value: "track"),
            URLQueryItem(name: "query", value: "bad bunny")
        ]
        
        guard let url = components.url else { return nil }
        print(url)
        var urlRequest = URLRequest(url: url)
        print(urlRequest)

        let token: String = UserDefaults.standard.value(forKey: "Authorization") as! String
        print("token: " + token)
        
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        return urlRequest
        
    }
//    https://api.spotify.com/v1/search?type=track&query=bad bunny
    
    
    func search() async throws -> [String] {
        print("search")
        guard let urlRequest = createURLRequest() else { throw NetworkError.invalidURL }
        print(urlRequest)
        print(urlRequest.allHTTPHeaderFields)
        
        let session = URLSession.shared
        do {
            let (data, response) = try await session.data(for: urlRequest)
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let results = try decoder.decode(Response.self, from: data)
            
            let list = results.tracks.items
            print(list)
//        } catch {
//            print(error)
//        }
//        } catch let DecodingError.dataCorrupted(context) {
//            print(context)
//        } catch let DecodingError.keyNotFound(key, context) {
//            print("Key '\(key)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch let DecodingError.valueNotFound(value, context) {
//            print("Value '\(value)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//        } catch let DecodingError.typeMismatch(type, context)  {
//            print("Type '\(type)' mismatch:", context.debugDescription)
//            print("codingPath:", context.codingPath)
        }
        catch {
            print("error: ", error)
            UserDefaults.standard.set(nil, forKey: "Authorization")

        }
        return []
        
    }
    
}


struct Response: Codable {
    let tracks: Track
}

struct Track: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name: String?
}
