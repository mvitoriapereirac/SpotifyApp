//
//  DailyStats.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 09/11/23.
//

import Foundation
import SwiftUI

struct DailyStats: View {
    let arrayValues: [Double]
    let arrayColors: [UIColor]
    
    var firstItem: Double {
        let item = arrayValues.first
        return item ?? 0.00
    }
    
    var secondItem: Double {
        let item = arrayValues[1]
        return item
    }
    
    var thirdItem: Double {
        let item = arrayValues[2]
        return item
    }
    
    var fourthItem: Double {
        let item = arrayValues[3]
        return item
    }
    
    var body: some View {
        
        
        
        if firstItem != 0.00 {
            Text("\(firstItem * 100)".masked)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                .font(.title3)
                .background(Color(arrayColors[0]).cornerRadius(4.0).opacity(0.8))

        }
        
        if secondItem != 0.00 {
            Text("\(secondItem * 100)".masked)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                .font(.title3)
                .background(Color(arrayColors[1]).cornerRadius(4.0).opacity(0.8))
        }
        
        if thirdItem != 0.00 {
            Text("\(thirdItem * 100)".masked)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                .font(.title3)
                .background(Color(arrayColors[2]).cornerRadius(4.0).opacity(0.8))
        }
        
        if fourthItem != 0.00 {
            Text("\(fourthItem * 100)".masked)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                .font(.title3)
                .background(Color(arrayColors[3]).cornerRadius(4.0).opacity(0.8))
        }
        
        //            ForEach(arrayValues, id: \.self) { item in
        //                if item != 0.00 {
        //                    if item == arrayValues[0] {
        //                        Text("\(item * 100)".masked)
        //                            .padding(.horizontal, 12)
        //                            .padding(.vertical, 4)
        //                            .foregroundColor(.white)
        //                            .frame(alignment: .leading)
        //                            .font(.title3)
        //                            .background(Color(arrayColors[0]).cornerRadius(4.0).opacity(0.8))
        //
        //
        //                    } else if item == arrayValues[1] {
        //                        Text("\(item * 100)".masked)
        //                            .padding(.horizontal, 12)
        //                            .padding(.vertical, 4)
        //                            .foregroundColor(.white)
        //                            .frame(alignment: .leading)
        //                            .font(.title3)
        //                            .background(Color(arrayColors[1]).cornerRadius(4.0).opacity(0.8))
        //
        //                    } else if item == arrayValues[2] {
        //                        Text("\(item * 100)".masked)
        //                            .padding(.horizontal, 12)
        //                            .padding(.vertical, 4)
        //                            .foregroundColor(.white)
        //                            .frame(alignment: .leading)
        //                            .font(.title3)
        //                            .background(Color(arrayColors[2]).cornerRadius(4.0).opacity(0.8))
        //
        //                    } else if item == arrayValues[3] {
        //                        Text("\(item * 100)".masked)
        //                            .padding(.horizontal, 12)
        //                            .padding(.vertical, 4)
        //                            .foregroundColor(.white)
        //                            .frame(alignment: .leading)
        //                            .font(.title3)
        //                            .background(Color(arrayColors[3]).cornerRadius(4.0).opacity(0.8))
        //
        //
        //
        //
        //                    }
        //                }
        //
        //
        //            }
        
        
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.white)
            .animation(.spring())
    }
}

