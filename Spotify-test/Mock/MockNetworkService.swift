//
//  MockNetworkService.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 15/12/23.
//

import Foundation
class MockNetworkService: NetworkServiceProtocol {
    func fetchData(for urlRequest: URLRequest, get data: String) async throws -> (Data, URLResponse) {
        let mockResponse = HTTPURLResponse(url: URL(string: "https://mockedurl.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)! // Replace with a mock response
        if data == "Songs" {
            let mockData = Data(MockJSON.songsMock.utf8) // Replace with your mock data
            return (mockData, mockResponse)

        }
        let mockData = Data("Mocked response data".utf8) // Replace with your mock data
        return (mockData, mockResponse)
    }
}
