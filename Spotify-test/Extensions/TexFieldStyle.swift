//
//  TexField.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 12/11/23.
//

import Foundation
import SwiftUI

extension TextField {
    
    func extensionTextFieldView(roundedCornes: CGFloat, startColor: Color,  endColor: Color, textColor: Color) -> some View {
        self
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 16))
        
//            .shadow(radius: 5)
        
    }
}
