//
//  File.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/10/23.
//

import Foundation
import SwiftUI

struct GridView: View {
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel = GridViewModel.shared
    
    
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
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 20, height: 30)
                    .padding()
                    .foregroundColor(Color(.purple))
                    .onTapGesture {
                        coordinator.goToHomePage()
                    }
                Spacer()
            }
            MoodCaption(color: .projectBlack)
            LazyVGrid(columns: columns) {
                Text("sunday")
                    .font(.headline)
                Text("monday")
                    .font(.headline)
                
                Text("tuesday")
                    .font(.headline)
                
                Text("wednesday")
                    .font(.headline)
                
                Text("thursday")
                    .font(.headline)
                
                Text("friday")
                    .font(.headline)
                
                Text("saturday")
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
                            ForEach(1...7, id: \.self) { index in
                                
                                if daysInfo.first?.weekday ?? 0 == index {
                                    
                                    if index != 0 && index != 1 && index != 2 {
                                        //                                                        if index != 0 {
                                        
                                        let arrayIterator = Array(1...(index-1))
                                        ForEach(arrayIterator, id: \.self) { i in
                                            RectangleView(RectColor: .clear, frame: 50)
                                            
                                            
                                        }
                                        
                                    }
                                    else if index == 2 {
                                        if index == 2 {
                                            RectangleView(RectColor: .clear, frame: 50)
                                            
                                        }
                                        //                                                            if index == 2 {
                                        //                                                                RectangleView(RectColor: .clear, frame: 50)
                                        //                                                                RectangleView(RectColor: .clear, frame: 50)
                                        //
                                        //                                                            }
                                        
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        
                        RectangleView(RectColor: dayInfo.color as! UIColor, frame: 50)
                            .onTapGesture {
                                viewModel.dayInfo = dayInfo
                                coordinator.goToResultsView()
                                
                            }
                        
                    }
                    
                }
                .padding()
            }
        }
        
        
    }
}


struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
        
    }
}


