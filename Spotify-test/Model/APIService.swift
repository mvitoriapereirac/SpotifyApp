//
//  APIService.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 17/10/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    var list: [LastListenedItem] = []
    var dict: [String : String] = [:]
    var genres: [[String]] = []
    let defaults = UserDefaults.standard
    let lastLogKey = UserDefaultsConstants.lastLog
    
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
    
    func createURLSearchRequest(searchQuery: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = "/v1/search"
        
        components.queryItems = [
            URLQueryItem(name: "type", value: "track"),
            URLQueryItem(name: "query", value: searchQuery)
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
    
    
    func createURLRecentlyListenedRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = APIConstants.recentlyPlayedPath
        
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
    
    func getRecentlyListened() async throws -> [LastListenedItem] {
        defaults.set(Date(), forKey: lastLogKey)

        guard let urlRequest = createURLRecentlyListenedRequest() else { throw NetworkError.invalidURL }
        print(urlRequest)
        
        let session = URLSession.shared
        do {
            let (data, _) = try await session.data(for: urlRequest)
            let decoder = JSONDecoder()
            let results = try decoder.decode(LastListenedResponse.self, from: data)
            
            
            let list = results.items
            
            print(list)
            print("lista ouvidos recentes")
            print(list.count)
            dict = APIService.shared.transformIntoDict(list: list)
            
            return list
        }
        catch {
            print("error: ", error)
            
        }
        
        return []
        
    }
    
    
    func createArtistsGenreURLRequests(dict: [String : String]) -> [URLRequest]? {
        var urlRequestsArray: [URLRequest] = []
        print(dict)
        for item in dict {
            guard let itemURL = URL(string: item.value) else { return urlRequestsArray }
            var urlRequest = URLRequest(url: itemURL)
            print(urlRequest)
            
            let token: String = UserDefaults.standard.value(forKey: "Authorization") as! String
            print("token: " + token)
            
            urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "GET"
            
            urlRequestsArray.append(urlRequest)
        }
        
        return urlRequestsArray
        
    }
    
    
    
    
    func transformIntoDict(list: [LastListenedItem]) -> [String : String]{
        var dict: [String : String] = [:]
        var nameAux = ""
        var aux = 0
        for item in list {
            let artists = item.track.artists
            for artist in artists {
                let url = artist.href
                let name = artist.name
                if dict.keys.contains(name) {
                    nameAux = name + "\(aux)"
                    dict.updateValue(url, forKey: nameAux)
                    aux += 1
                    
                    
                } else {
                    dict.updateValue(url, forKey: name)
                }
            }
        }
        print("lista dict")
        print(dict)
        return dict
        
    }
    
    func getRecentlyPlayedGenres() async throws -> [[String]] {
        var genresArray: [[String]] = []
        guard let urlRequestArray = createArtistsGenreURLRequests(dict: dict) else { throw NetworkError.invalidURL }
        let session = URLSession.shared
        for item in urlRequestArray {
            do {
                let (data, _) = try await session.data(for: item)
                let decoder = JSONDecoder()
                let results = try decoder.decode(GenresResponse.self, from: data)
                let genres = results.genres
                genresArray.append(genres)
                
            } catch {
                print("error: ", error)
                UserDefaults.standard.set(nil, forKey: "Authorization")
                
            }
        }
        
        
        return genresArray
        
    }
    
    
}






