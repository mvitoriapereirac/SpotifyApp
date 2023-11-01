//
//  Rectangle.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/10/23.
//

import Foundation
import SwiftUI

struct RectangleView: View {
    @ObservedObject private var viewModel = ResultsViewModel(genres: [[]], genresAmountDict: [:], current: [])
    @EnvironmentObject var coordinator: Coordinator
    let RectColor: UIColor
    let frame: CGFloat
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: frame, height: frame)
                .foregroundColor(Color(RectColor))
                
                .onTapGesture {
                    coordinator.goToResultsView()
                    
                    
                }
        }
       
    }
}
