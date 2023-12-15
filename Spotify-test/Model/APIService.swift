//
//  APIService.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 17/10/23.
//

import Foundation


protocol NetworkServiceProtocol {
    func fetchData(for urlRequest: URLRequest) async throws -> (Data, URLResponse)
    // ... other networking methods
}

class NetworkService: NetworkServiceProtocol {
    func fetchData(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        // Real implementation using URLSession
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return (data, response)
    }
}


class APIService {
    static let shared = APIService(networkService: NetworkService())
    var list: [LastListenedItem] = []
    var dict: [String : String] = [:]
    var genres: [[String]] = []
    let defaults = UserDefaults.standard
    let lastLogKey = UserDefaultsConstants.lastLog
    let networkService: NetworkServiceProtocol // Injected dependency
       
       init(networkService: NetworkServiceProtocol) {
           self.networkService = networkService
       }
    
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
    

    
    func createURLRecentlyListenedRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = APIConstants.recentlyPlayedPath
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        let token: String = UserDefaults.standard.value(forKey: "Authorization") as! String
        print("token: " + token)
        
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    func getRecentlyListened() async throws {
        defaults.set(Date(), forKey: lastLogKey)
        var list: [LastListenedItem] = []
        guard let urlRequest = createURLRecentlyListenedRequest() else { throw NetworkError.invalidURL }
        
            do {

                let (data, _) = try await networkService.fetchData(for: urlRequest)
                let decoder = JSONDecoder()
                let results = try decoder.decode(LastListenedResponse.self, from: data)


                list = results.items

                print(list)
                print("lista ouvidos recentes")
                print(list.count)
                self.dict = APIService.shared.transformIntoDict(list: list)

            }
            catch {
                print("error: ", error)

            }
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
   
        return dict
        
    }
    
    func getRecentlyPlayedGenres() async throws {
        guard let urlRequestArray = createArtistsGenreURLRequests(dict: dict) else { throw NetworkError.invalidURL }
        for item in urlRequestArray {
            do {
                let (data, _) = try await networkService.fetchData(for: item)
                let decoder = JSONDecoder()
                let results = try decoder.decode(GenresResponse.self, from: data)
                let genres = results.genres
                self.genres.append(genres)
                
            } catch {
                print("error: ", error)
                UserDefaults.standard.set(nil, forKey: "Authorization")
                
            }
        }
        
                
    }
    
    
}






