//
//  FlowerAnimation.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 08/11/23.
//

import Foundation
import SwiftUI
struct FlowerAnimation: View {
    @State private var breath = false
    let color: Color
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
            .scaleEffect(1.2)
            ZStack {
                ZStack { // Vertical
                    ZStack { // Square gradient
                        RadialGradient(gradient: Gradient(colors: [Color.clear, color, color]), center: .center, startRadius: 5, endRadius: 100)
                            .clipShape(Circle()).frame(width: 80, height: 80) // Clip gradient to circle
                            .offset(y: -41)
                    }
                    
                    ZStack {
                        RadialGradient(gradient: Gradient(colors: [Color.clear, color, color]), center: .center, startRadius: 5, endRadius: 90)
                            .clipShape(Circle()).frame(width: 80, height: 80)
                            .offset(y: 41)
                    }
                }.opacity(0.5)
                
            ZStack { // At 60°
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [Color.clear, color, color]), center: .center, startRadius: 5, endRadius: 100)
                        .clipShape(Circle()).frame(width: 80, height: 80)
                        .offset(y: -41)
                }
                
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [Color.clear, color, color]), center: .center, startRadius: 5, endRadius: 90)
                        .clipShape(Circle()).frame(width: 80, height: 80)
                        .offset(y: 41)
                }
            }.opacity(0.5).rotationEffect(.degrees(60), anchor: .center)
                
            ZStack { // At 60*2°
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [Color.clear, color, color]), center: .center, startRadius: 5, endRadius: 100)
                        .clipShape(Circle()).frame(width: 80, height: 80)
                        .offset(y: -41)
                }
                
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [Color.clear, color, color]), center: .center, startRadius: 5, endRadius: 90)
                        .clipShape(Circle()).frame(width: 80, height: 80)
                        .offset(y: 41)
                }
            }.opacity(0.5).rotationEffect(.degrees(60*2), anchor: .center)
                
            }// Whole flower
            .rotationEffect(.degrees(breath ? 360 : 0), anchor: .center) // Inhale = clockwise rotation, Exhale = anticlockwise rotation
            .scaleEffect(breath ? 1 : 0.2) // Inhale = upscale, Exhale = downscale
            .animation(Animation.easeInOut(duration: 4).delay(1))
                .opacity(breath ? 1 : 0.5)
            .onAppear() {
                    self.breath = true
            }
              
        }
    }
}

