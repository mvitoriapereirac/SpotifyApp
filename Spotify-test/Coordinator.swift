//
//  File.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 31/10/23.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: [Route] = []
    
    func goBackOnePage() {
        path.removeLast(1)
    }
    
    func popView(view: Route) {
        for element in path {
            if element == view {
                path.remove(at:(path.firstIndex(of: element) ?? 0))

            }
        }
    }
    func gotoHomePage() {
        path.removeLast(path.count)
    }
    
    func goToHomePage() {
        path.append(Route.homeView)
    }
    
    func goTo(view: Route) {
        path.append(view)
    }
    
   
    
    func goToGridView() {
        path.append(Route.gridView)
    }
    
    func goToResultsView() {
        path.append(Route.resultsView)
    }
    
    func goToTodaysResultsView() {
        path.append(Route.todaysResultsView)
    }
}

enum Route: Hashable {
    case todaysResultsView
    case resultsView
    case gridView
    case homeView
}
