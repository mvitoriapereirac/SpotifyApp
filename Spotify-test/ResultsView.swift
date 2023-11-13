//
//  TodayResultsView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/10/23.
//

import Foundation
import SwiftUI

struct ResultsView: View {
    @ObservedObject private var viewModel = ResultsViewModel(genres: [[]], genresAmountDict: [:], current: [])
    @EnvironmentObject var coordinator: Coordinator
    let isFirstVisitToday: Bool
    let logManager = DailyLogManager.shared

//    @ObservedObject private var viewModel: RectangleViewModel
//    init(viewModel: RectangleViewModel) {
//        self.viewModel = viewModel
//    }
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
    @Environment(\.managedObjectContext) var moc
    @State var showGrid = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Text("O seu resultado foi")
                            .onTapGesture(perform: {
                                coordinator.goToGridView()
                                print("tapa")
                            })
                        
                    }
                    VStack {
                            RectangleView(RectColor: viewModel.makeUIColorBlend(), frame: 300)
                        Button(action: {
                            coordinator.gotoHomePage()
                        }) {
                            Text("back")
                        }
                                
                                    
                                
                        
                    }
                    
                    
                }
                
            }
            
        }
        
        .onAppear {
            viewModel.genresArray()
            

            if isFirstVisitToday {
                print(logManager.daysOfAbsence)
                if logManager.daysOfAbsence.count != 0 {
                    print("michael jackson")
                    print(logManager.daysOfAbsence.count)

                    for _ in logManager.daysOfAbsence {
                        let dayInfo = DayInfo(context: moc)
//                        dayInfo.weekday = Int16(viewModel.weekday)
//                        dayInfo.day = Int16(viewModel.day)
//                        dayInfo.month = Int16(viewModel.month)

                        dayInfo.color = UIColor.clear
                        try? moc.save()

                    }
                }
                
                let dayInfo = DayInfo(context: moc)
                dayInfo.weekday = Int16(viewModel.weekday)
                dayInfo.color = viewModel.makeUIColorBlend()
                dayInfo.day = Int16(viewModel.day)
                dayInfo.month = Int16(viewModel.month)
                try? moc.save()
            }
            
            

        }
        
    }
}
