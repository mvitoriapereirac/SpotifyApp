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
    @ObservedObject var viewModel  = GridViewModel()


    let weekDays = ["Dom": 0, "Seg": 1, "Ter": 2, "Qua": 3, "Qui": 4, "Sex": 5, "Sab": 6]
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
        ScrollView {
            LazyVGrid(columns: columns) {
                Text("D")
                Text("S")
                Text("T")
                Text("Q")
                Text("Q")
                Text("S")
                Text("S")

//
//
//
                
                ForEach(daysInfo, id: \.self) { dayInfo in
                    if dayInfo == daysInfo.first {
                        ForEach(0...6, id: \.self) { index in
                            
                            if daysInfo.first?.weekday ?? 0 == index {

                                if index != 0 {
                                    let arrayIterator = Array(1...(index - 1))
                                    ForEach(arrayIterator, id: \.self) { i in
                                        RectangleView(RectColor: .clear, frame: 50)
                                    }

                                }
                                
                                
                                
                            }
                        }

                    }
                    
                    RectangleView(RectColor: dayInfo.color as! UIColor, frame: 50)
                   
                }

            }
            .onAppear{
                print("aqui \(daysInfo)")
            }
            .padding()
        }

    }
}

class GridViewModel: ObservableObject {
    func makeBlankSpaces(index: Int) -> [RectangleView] {
        let arrayIterator = Array(0...index)
        var arrayBlankRects: [RectangleView] = []
        if index == 0 {
            return []
        } else {
            for _ in arrayIterator {
                arrayBlankRects.append(RectangleView(RectColor: .clear, frame: 50))
            }
            
        }
        
       return arrayBlankRects
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
        
    }
}


