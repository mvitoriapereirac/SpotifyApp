//
//  MoodCaption.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 14/11/23.
//

import Foundation
import SwiftUI

struct MoodCaption: View {
    let color: Color
    var arrayMoods: [Mood] {
        let mainMoods = MainMoods()
        var list: [Mood] = []
        list.append(mainMoods.fun)
        list.append(mainMoods.bright)
        list.append(mainMoods.dark)
        list.append(mainMoods.soft)
        return list
    }
    
    let rows = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.fixed(120)),
            GridItem(.flexible())
        ]

    
    var body: some View {
        
            LazyVGrid(columns: rows, spacing: 5) {
                ForEach(arrayMoods, id: \.self) { item in
                    HStack(spacing: 5) {
                        Rectangle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(item.color))
                            .cornerRadius(15.0)
                        
                        
                        Text(item.mood)
                            .foregroundColor(color)

                            .font(.footnote)
                    }
                }
                
            }
            
        }
    
    
}
struct MoodCaptionView_Previews: PreviewProvider {
    static var previews: some View {
        MoodCaption(color: .black)
    }
}
