//
//  ButtonStyle.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 12/11/23.
//

import Foundation
import SwiftUI

extension ButtonStyle where Self == NeumorphicButtonStyle {
    static var neumorphicGray: Self { Self(bgColor: .gray) }
    static var neumorphicPurple: Self {Self(bgColor: Color(.purple))}
}


struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 8)

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
            .font(.headline.bold())
            .animation(.spring())
    }
}

