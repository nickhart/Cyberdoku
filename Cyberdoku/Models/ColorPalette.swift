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
    // New background roles
    let cellBackgroundEmptyShaded: Color
    let cellBackgroundEmptyUnshaded: Color
    let cellBackgroundUserEntry: Color
    let cellBackgroundOriginalShaded: Color
    let cellBackgroundOriginalUnshaded: Color

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
            numberColors: base.generateColorGradient(count: 9),
            cellBackgroundEmptyShaded: isDark ? Color(white: 0.2) : Color(white: 0.9),
            cellBackgroundEmptyUnshaded: isDark ? Color(white: 0.15) : Color(white: 0.95),
            cellBackgroundUserEntry: isDark ? Color.cyan.opacity(0.2) : Color.blue.opacity(0.15),
            cellBackgroundOriginalShaded: isDark ? Color(white: 0.8) : Color(white: 0.25),
            cellBackgroundOriginalUnshaded: isDark ? Color(white: 0.85) : Color(white: 0.3)
        )
    }

    static let defaultAccessible = ColorPalette(
        name: "Default Accessible",
        screenBackground: Color(white: 1.0),
        cellBackground: Color(white: 0.95),
        cellSelectedBackground: .cyan.opacity(0.4),
        shadedBoxBackground: Color(white: 0.9),
        agentModifiedBackground: .green.opacity(0.5),
        borderColor: .black,
        numberColors: [
            .black, .blue, .red, .green, .purple, .orange, .brown, .pink, .indigo
        ],
        cellBackgroundEmptyShaded: Color(white: 0.85),
        cellBackgroundEmptyUnshaded: Color(white: 0.95),
        cellBackgroundUserEntry: .blue.opacity(0.2),
        cellBackgroundOriginalShaded: Color(white: 0.75),
        cellBackgroundOriginalUnshaded: Color(white: 0.85)
    )

    static var all: [ColorPalette] {
        [defaultAccessible] + gradientPalettes.flatMap { palette in
            [themed(palette, for: .light), themed(palette, for: .dark)]
        }
    }
}

extension ColorPalette {
    static func named(_ name: String, for scheme: ColorScheme) -> ColorPalette {
        if name == defaultAccessible.name {
            return defaultAccessible
        }
        if let set = gradientPalettes.first(where: { name.contains($0.name) }) {
            return themed(set, for: scheme)
        }
        // Fallback
        return defaultAccessible
    }
}
