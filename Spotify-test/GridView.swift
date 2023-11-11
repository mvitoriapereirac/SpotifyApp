//
//  File.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/10/23.
//

import Foundation
import SwiftUI

struct GridView: View {
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfoExtension>
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel = GridViewModel.shared
    private var context = DataController.shared.container.viewContext

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            MoodCaption(color: .projectWhite)
            LazyVGrid(columns: columns) {
                Text("D")
                    .font(.headline)
                Text("S")
                    .font(.headline)
                
                Text("T")
                    .font(.headline)
                
                Text("Q")
                    .font(.headline)
                
                Text("Q")
                    .font(.headline)
                
                Text("S")
                    .font(.headline)
                
                Text("S")
                    .font(.headline)
            }
            .padding()
            
            ScrollView {
                
                LazyVGrid(columns: columns) {
                    
//                    if daysInfo.first?.weekday != 0 || daysInfo.first?.weekday != 1 || daysInfo.first?.weekday != 2 {
//                        ForEach(1...((daysInfo.first?.weekday ?? 0) - 1), id: \.self) { _ in
//                            RectangleView(RectColor: .clear, frame: 50)
//
//                        }
//                        ForEach(daysInfo, id: \.self) { dayInfo in
//                            RectangleView(RectColor: dayInfo.color as! UIColor, frame: 50)
//                                .onTapGesture {
//                                    viewModel.colorFromSelected = dayInfo.color as? UIColor
//                                    viewModel.dayFromSelected = Int(dayInfo.day)
//                                    viewModel.monthFromSelected = Int(dayInfo.month)
//                                    viewModel.weekdayFromSelected = Int(dayInfo.weekday)
//                                    coordinator.goToResultsView()
//
//                                }
//                        }
//                    }
                    
                    
                                        ForEach(daysInfo, id: \.self) { dayInfo in
                                            if dayInfo == daysInfo.first {
                                                ForEach(0...6, id: \.self) { index in
                    
                                                    if daysInfo.first?.weekday ?? 0 == index {
                    
                                                        if index != 0 || index != 1 || index != 2 {
                                                            let arrayIterator = Array(1...(index - 1))
                                                            ForEach(arrayIterator, id: \.self) { i in
                                                                RectangleView(RectColor: .clear, frame: 50)
                    
                     
                                                            }
                    
                                                        }
                                                        else if index == 1 || index == 2 {
                                                            if index == 1 {
                                                                RectangleView(RectColor: .clear, frame: 50)

                                                            }
                                                            if index == 2 {
                                                                RectangleView(RectColor: .clear, frame: 50)
                                                                RectangleView(RectColor: .clear, frame: 50)

                                                            }

                                                        }
                    
                    
                    
                                                    }
                                                }
                    
                                            }
                    
                                            RectangleView(RectColor: dayInfo.color as! UIColor, frame: 50)
                                                .onTapGesture {
                                                    viewModel.colorFromSelected = dayInfo.color as? UIColor
                                                    viewModel.dayFromSelected = Int(dayInfo.day)
                                                    viewModel.monthFromSelected = Int(dayInfo.month)
                                                    viewModel.weekdayFromSelected = Int(dayInfo.weekday)
//                                                    viewModel.dayInfo = dayInfo
                                                    coordinator.goToResultsView()
                    
                                                    }
                    
                    
                    
                    
                    
                    
                                        }
                    
                }
                .onAppear{
                    print("aqui \(daysInfo)")
                }
                .padding()
            }
        }
        
        
    }
}

class GridViewModel: ObservableObject {
    
    static let shared = GridViewModel()
    @Published var dayFromSelected: Int? = 0
    @Published var monthFromSelected: Int? = 0
    @Published var weekdayFromSelected: Int? = 0
    @Published var colorFromSelected: UIColor? = UIColor.clear
    @Published var dayInfo: FetchedResults<DayInfoExtension>.Element? = nil
    
    
    
    //TO DO: implement this method on a details manager
    func makeDetailedResultsView() -> ResultsView {
        return ResultsView(isFirstVisitToday: false, dayFromSelected: self.dayFromSelected, monthFromSelected: self.monthFromSelected, weekdayFromSelected: self.weekdayFromSelected, colorFromSelected: self.colorFromSelected, dayInfo: self.dayInfo)
        
        
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
        
    }
}


