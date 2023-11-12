//
//  Color.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 24/10/23.
//

import Foundation
import UIKit
import SwiftUI
extension UIColor {
    static let RGBRed = UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let RGBGreen = UIColor(red: 0.0, green: 255.0, blue: 0.0, alpha: 1.0)
    static let RGBBlue = UIColor(red: 0.0, green: 0.0, blue: 255.0, alpha: 1.0)
    static let RGBYellow = UIColor(red: 127.5, green: 127.5, blue: 0, alpha: 1.0)
    static let RGBCyan = UIColor(red: 0, green: 127.5, blue: 127.5, alpha: 1.0)
    static let RGBMagenta = UIColor(red: 127.5, green: 0, blue: 127.5, alpha: 1)

    
    static func blend(color1: UIColor, intensity1: CGFloat = 0.5, color2: UIColor, intensity2: CGFloat = 0.5, color3: UIColor, intensity3: CGFloat = 0.5, color4: UIColor, intensity4: CGFloat = 0.5) -> UIColor {
        let total = intensity1 + intensity2 + intensity3 + intensity4
        let l1 = intensity1/total
        let l2 = intensity2/total
        let l3 = intensity3/total
        let l4 = intensity4/total
       
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r3, g3, b3, a3): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r4, g4, b4, a4): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)



        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        color3.getRed(&r3, green: &g3, blue: &b3, alpha: &a3)
        color4.getRed(&r4, green: &g4, blue: &b4, alpha: &a4)


//        return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: 0, alpha: l1*a1 + l2*a2)
        let colorMix = UIColor(red: l1*r1 + l2*r2 + l3*r3 + l4*r4, green: l1*g1 + l2*g2 + l3*g3 + l4*g4, blue: l1*b1 + l2*b2 + l3*b3 + l4*b4, alpha: l1*a1 + l2*a2 + l3*a3 + l4*a4)
        print(colorMix)
        return colorMix
//        return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
    }
}

extension Color {
   static let projectBlack = Color("projectBlack")
    static let projectWhite = Color("projectWhite")
}
