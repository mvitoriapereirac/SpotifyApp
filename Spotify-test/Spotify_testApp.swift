//
//  Spotify_testApp.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/09/23.
//

import SwiftUI

@main
struct Spotify_testApp: App {
    @StateObject private var dataController = DataManager()
    
    var body: some Scene {
        WindowGroup {
            AppNavigation()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
