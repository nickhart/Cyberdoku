//
//  ColorPalette.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation
import SwiftUI

struct ColorPalette {
    let name: String
    let screenBackground: Color
    let cellBackground: Color
    let cellSelectedBackground: Color
    let shadedBoxBackground: Color
    let agentModifiedBackground: Color
    let borderColor: Color
    let numberColors: [Color]

    func color(for number: Int) -> Color {
        if number == 0 {
            return .black
        } else if number >= 1 && number <= 9 {
            return numberColors[number - 1]
        } else {
            return .gray
        }
    }
}

extension ColorPalette {
    static let gradientPalettes: [GradientColorSet] = [
        GradientColorSet(name: "Rainbow", colors: [.red, .yellow, .green, .blue]),
        GradientColorSet(name: "Sunset", colors: [.orange, .pink, .purple, .indigo]),
        GradientColorSet(name: "Ocean", colors: [.teal, .cyan, .blue, .indigo]),
        GradientColorSet(name: "Pastel", colors: [.mint, .pink, .peach, .lavender])
    ]

    static func themed(_ base: GradientColorSet, for scheme: ColorScheme) -> ColorPalette {
        let isDark = scheme == .dark
        return ColorPalette(
            name: "\(base.name) \(isDark ? "Dark" : "Light")",
            screenBackground: isDark ? Color.black : Color.white,
            cellBackground: isDark ? Color(white: 0.15) : Color(white: 0.95),
            cellSelectedBackground: .cyan.opacity(0.5),
            shadedBoxBackground: isDark ? Color(white: 0.2) : Color(white: 0.8),
            agentModifiedBackground: .green.opacity(0.5),
            borderColor: isDark ? .white : .gray,
            numberColors: base.generateColorGradient(count: 9)
        )
    }

    static var all: [ColorPalette] {
        gradientPalettes.flatMap { palette in
            [themed(palette, for: .light), themed(palette, for: .dark)]
        }
    }
}
