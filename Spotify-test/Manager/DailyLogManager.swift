//
//  DailyLogManager.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 01/11/23.
//

//This class asserts that the user can only check their stats once a day.
import Foundation
class DailyLogManager: NSObject, ObservableObject {

    static let shared = DailyLogManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = UserDefaultsConstants.lastLog
    private let calendar = Calendar.current
    var daysOfAbsence: [Int] = []
    @Published var shouldRefresh = false
    

    func AllowLogButtonIfNeeded(completion: (Bool) -> Void) {

        if isRefreshRequired() {
            // load the data
//            defaults.set(Date(), forKey: defaultsKey)
            completion(true)
        } else {
            completion(false)
        }
    }

    private func isRefreshRequired(userPickedHour: Int = 17) -> Bool {

        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            shouldRefresh = true
            return shouldRefresh
        }

        if let diff = calendar.dateComponents([.day], from: lastRefreshDate, to: Date()).day,
            let currentHour =  calendar.dateComponents([.hour], from: Date()).hour,
            diff >= 1, userPickedHour <= currentHour {
            addBlankDays(diff: diff)
            shouldRefresh = true
            return shouldRefresh
        } else {
            return shouldRefresh
        }
    }
    
    private func addBlankDays(diff: Int) {
        if diff > 1 {
            daysOfAbsence = Array(1...(diff - 1))
        }
    }
}
