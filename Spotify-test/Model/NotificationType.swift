//
//  NotificationType.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 15/11/23.
//

import Foundation
import SwiftUI

//In case I decide to expand my notifications feature in future versions
enum NotificationType {
    case timeIsUp
    
    var identifier: String {
        switch self {
        case .timeIsUp:
            return "timeIsUp"
        }
    }
    
    var title: String {
        switch self {
        case .timeIsUp:
            return "Tá na hora"
        }
    }
    
    var body: String {
        switch self {
        case .timeIsUp:
            return "Descubra agora suas tendências musicais (e afetivas!) de hoje"
        }
    }

    
    var repeats: Bool {
        switch self {
        case .timeIsUp:
            return true
        }
    }
    
    var sound: UNNotificationSound {
        switch self {
        case .timeIsUp:
            return .default
        }
    }
    
    
}

