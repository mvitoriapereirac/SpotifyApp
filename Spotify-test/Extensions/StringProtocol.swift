//
//  StringProtocol.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 08/11/23.
//

import Foundation
extension StringProtocol {
    var masked: String {
        return prefix(4) + String("%")
    }
}
