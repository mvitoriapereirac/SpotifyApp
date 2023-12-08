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

// Function to generate mock LastListenedResponse for testing
func createMockLastListenedResponse() -> LastListenedResponse {
    let artist1 = Artists(href: "artist1link", name: "Artist 1")
    let artist2 = Artists(href: "artist2link", name: "Artist 2")
    
    let track1 = LastListenedTrack(name: "Song Title 1", artists: [artist1])
    let track2 = LastListenedTrack(name: "Song Title 2", artists: [artist2])
    
    let item1 = LastListenedItem(track: track1)
    let item2 = LastListenedItem(track: track2)
    
    let items = [item1, item2]
    
    return LastListenedResponse(items: items)
}
