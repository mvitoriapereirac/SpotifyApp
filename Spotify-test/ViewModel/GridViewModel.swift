//
//  GridViewModel.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
import SwiftUI
class GridViewModel: ObservableObject {
    
    static let shared = GridViewModel()
    @Published var dayInfo: FetchedResults<DayInfo>.Element? = nil
    
    
    
    //TO DO: implement this method on a details manager
    func makeDetailedResultsView() -> ResultsView {
        return ResultsView(isFirstVisitToday: false, dayInfo: self.dayInfo)
        
        
    }
}
