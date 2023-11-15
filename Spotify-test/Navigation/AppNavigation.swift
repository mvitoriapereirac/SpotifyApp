//
//  AppNavigation.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 31/10/23.
//

import Foundation
import SwiftUI

struct AppNavigation: View {
    @ObservedObject var coordinator = Coordinator()
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $coordinator.path){
                selectedScreen
            }
            .environmentObject(coordinator)
            
        } else {
                // TO DO: Fallback on earlier versions
            }
        }
        
        @available(iOS 16.0, *)
        private var selectedScreen: some View {
            OnboardingView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .gridView:
                        GridView()
                            .navigationBarBackButtonHidden(true)

                    case .resultsView:
                        GridViewModel.shared.makeDetailedResultsView()
                            .navigationBarBackButtonHidden(true)
                            
                        
                    case .homeView:
                        HomeView()
                            .navigationBarBackButtonHidden(true)

                        
                    case .todaysResultsView:
                        ResultsView(isFirstVisitToday: true)
                            .navigationBarBackButtonHidden(true)

                    }
                    
                }
        }
    
}
