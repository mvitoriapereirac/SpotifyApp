//
//  NetworkError.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 17/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case generalError
}
