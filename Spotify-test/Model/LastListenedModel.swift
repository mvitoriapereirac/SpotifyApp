//
//  LastListenedModel.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
//LAST LISTENED STRUCTS

struct LastListenedResponse: Codable {
    let items: [LastListenedItem]
}

struct LastListenedItem: Codable {
    let track: LastListenedTrack
}

struct LastListenedTrack: Codable {
    let name: String
    let artists: [Artists]
}

struct Artists: Codable {
    let href: String
    let name: String
}
