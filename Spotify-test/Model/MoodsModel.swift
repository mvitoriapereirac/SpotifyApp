//
//  MoodsModel.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 15/11/23.
//

import Foundation
import SwiftUI

struct Mood: Hashable {
    let genres: [String]
    let color: UIColor
    let mood: String
    
    init(genres: [String], color: UIColor, mood: String) {
        self.genres = genres
        self.color = color
        self.mood = mood
    }
}

struct MainMoods: Hashable {
    let dark = Mood(genres: GenresList.rockGenres, color: .blue, mood: NSLocalizedString("introspective", comment: ""))
    let bright = Mood(genres: GenresList.brGenres, color: .orange, mood: NSLocalizedString("cheerful", comment: ""))
    let fun = Mood(genres: GenresList.popGenres, color: .systemPink, mood: NSLocalizedString("festive", comment: ""))
    let soft = Mood(genres: GenresList.indieGenres, color: .purple, mood:  NSLocalizedString("soft", comment: ""))
}
