//
//  LoadingBar.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 12/11/23.
//

import Foundation
import SwiftUI

struct LoadingBar: View {
    @State private var moveRightLeft = false
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: 128, height: 6, alignment: .center)
                .foregroundColor(Color(.systemGray4))
            Capsule()
                .clipShape(Rectangle().offset(x: moveRightLeft ? 80 : -80))
                .frame(width: 100, height: 6, alignment: .leading)
                .foregroundColor(Color(.systemMint))
//                .offset(x: moveRightLeft ? 14 : -14)
                .animation(Animation.easeInOut(duration: 0.5).delay(0.2).repeatForever(autoreverses: true))
                .onAppear {
                    moveRightLeft.toggle()
                }
        }
    }
}
