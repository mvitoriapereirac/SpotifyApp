//
//  APIService.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 17/10/23.
//

import Foundation




class APIService: ObservableObject {
    static let shared = APIService()
    var list: [LastListenedItem] = []
    var dict: [String : String] = [:]
    var genres: [[String]] = []


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
//    https://api.spotify.com/v1/search?type=track&query=bad bunny
    
    
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
        guard let urlRequest = createURLRecentlyListenedRequest() else { throw NetworkError.invalidURL }
        print(urlRequest)
        
        let session = URLSession.shared
        do {
            let (data, response) = try await session.data(for: urlRequest)
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let results = try decoder.decode(LastListenedResponse.self, from: data)
            
//            let list = results.tracks.items
//            let list = results.items[0].tracks.artists[0].href
            let list = results.items

//            let songs = list.map({$0.track})
            print(list)
            print("lista ouvidos recentes")
            print(list.count)
            dict = APIService.shared.transformIntoDict(list: list)

            return list
//
        }
        catch {
            print("error: ", error)
//            UserDefaults.standard.set(nil, forKey: "Authorization")

        }
        
        return []

    }
    
    func getNameAndURLStrings() {
        Task {
            try await list = APIService.shared.getRecentlyListened()
//            dict = APIService.shared.transformIntoDict(list: list)
            
            try await genres = APIService.shared.getRecentlyPlayedGenres()
            print("********")

            print(dict)
        }
         
    
    }
    
    func createArtistsGenreURLRequests(dict: [String : String]) -> [URLRequest]? {
        var urlRequestsArray: [URLRequest] = []
        print(dict)
        for item in dict {
            let urlString = item.value
            print(";;;;;;;;;;;;;;")
            print(urlString)
            var pathString = ""
            if !urlString.isEmpty {
                if urlString.contains("/artists/") {
                    let range = urlString.range(of:"/artists/")
                    guard let index = range?.upperBound else { return urlRequestsArray }
                    pathString = String(urlString[index...])
                    
                }
                
            }
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = APIConstants.apiHost
            components.path = APIConstants.artistInfoPath + pathString
            
            guard let url = components.url else { return urlRequestsArray }
            print(url)
            var urlRequest = URLRequest(url: url)
            print(urlRequest)

            let token: String = UserDefaults.standard.value(forKey: "Authorization") as! String
            print("token: " + token)
            
            urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "GET"
            
            urlRequestsArray.append(urlRequest)
        }
        
        print("=============")
        print(urlRequestsArray)
        return urlRequestsArray
        
    }
    
    

    
    func transformIntoDict(list: [LastListenedItem]) -> [String : String]{
        var dict: [String : String] = [:]
        let amount = list.count
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
                let (data, response) = try await session.data(for: item)
                let decoder = JSONDecoder()
                let results = try decoder.decode(GenresResponse.self, from: data)
                let genres = results.genres
                genresArray.append(genres)
                
            } catch {
                print("error: ", error)
                UserDefaults.standard.set(nil, forKey: "Authorization")

            }
        }
        
        print("&&&&&")
        print(genresArray)
        return genresArray

    }
    
    func search(artist: String) async throws -> [String] {
        print("search")
        guard let urlRequest = createURLSearchRequest(searchQuery: artist) else { throw NetworkError.invalidURL }
        print(urlRequest)
        print(urlRequest.allHTTPHeaderFields)
        
        let session = URLSession.shared
//        var list: [Item] = []
        do {
            let (data, response) = try await session.data(for: urlRequest)
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let results = try decoder.decode(Response.self, from: data)
            
            let list = results.tracks.items
            let songs = list.map({$0.name})
            print(list)
            return songs
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

//SEARCH STRUCTS
struct Response: Codable {
    let tracks: Track
}

struct Track: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name: String
}




