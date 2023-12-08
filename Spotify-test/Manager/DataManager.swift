//
//  DataController.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 31/10/23.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    let container = NSPersistentContainer(name: "DayInfo")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
}
//