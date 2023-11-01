//
//  DailyLogManager.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 01/11/23.
//

import Foundation
class DailyLogManager: NSObject {

    static let shared = DailyLogManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastLog"
    private let calendar = Calendar.current

    func AllowLogButtonIfNeeded(completion: (Bool) -> Void) {

        if isRefreshRequired() {
            // load the data
            defaults.set(Date(), forKey: defaultsKey)
            completion(true)
        } else {
            completion(false)
        }
    }

    private func isRefreshRequired(userPickedHour: Int = 18) -> Bool {

        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }

        if let diff = calendar.dateComponents([.day], from: lastRefreshDate, to: Date()).day,
            let currentHour =  calendar.dateComponents([.hour], from: Date()).hour,
            diff >= 1, userPickedHour <= currentHour {
            return true
        } else {
            return false
        }
    }
}
