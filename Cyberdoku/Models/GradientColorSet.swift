//
//  GradientColorSet.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/27/25.
//

import SwiftUI

struct GradientColorSet {
    let name: String
    let colors: [Color]
    
    func generateColorGradient(count: Int) -> [Color] {
        ColorGradientPalette.generateColors(from: colors, count: count)
    }
}

extension GradientColorSet {
    static let rainbow = GradientColorSet(name: "Rainbow", colors: [.red, .orange, .yellow, .green, .blue])
    static let sunset = GradientColorSet(name: "Sunset", colors: [.pink, .orange, .purple, .indigo])
    static let ocean = GradientColorSet(name: "Ocean", colors: [.mint, .teal, .blue, .indigo])
    static let pastel = GradientColorSet(name: "Pastel", colors: [.peach, .lavender, .mint, .skyBlue]) // define these custom colors
}
