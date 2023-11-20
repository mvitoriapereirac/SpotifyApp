//
//  GenresModel.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
import SwiftUI
//GENRES STRUCT

struct GenresResponse: Codable {
    let genres: [String]
    let name: String
}

struct GenresList {
    static let brGenres = ["tropicalia", "bossa nova", "mpb", "samba", "pagode", "brega", "sertanejo", "funk", "forr", "brasileir"]
    static let popGenres = ["pop", "edm", "house", "techno","trap", "disco", "r&b", "soul", "psy", "trance"]
    static let rockGenres = ["rock", "metal", "screamo", "breakcore", "hip hop", "shoegaze", "rap", "prog", "punk"]
    static let indieGenres = ["indie", "chamber", "bedroom", "soft", "lofi", "chill", "jazz"]
}
