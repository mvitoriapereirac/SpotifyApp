//
//  GenresModel.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
//GENRES STRUCT

struct GenresResponse: Codable {
    let genres: [String]
    let name: String
}
