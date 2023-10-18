//
//  APIConstants.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 17/10/23.
//

import Foundation

enum APIConstants {
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientId = "047dfc0bd62a4b85aeb20ea88e24a726"
    static let clientSecret = "986d9e46d118485eb2703cb33518f7f9"
    static let redirectUrl = "https://google.com"
    static let responseType = "token"
    static let scopes = "user-read-private"
    
    static var authParams = [
        "client_id": clientId,
        "response_type": responseType,
        "redirect_uri": redirectUrl,
        "scope": scopes
    ]
}
