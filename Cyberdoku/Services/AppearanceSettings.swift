//
//  AppearanceSettings.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/27/25.
//


import SwiftUI

final class AppearanceSettings: ObservableObject {
    @Published var selectedPaletteName: String = "rainbow" // Persist this if needed
    @Published var resolvedPalette: ColorPalette

    init(colorScheme: ColorScheme) {
        // Start with a default; could use UserDefaults to persist if desired
        self.resolvedPalette = ColorPalette.themed(.rainbow, for: colorScheme)
    }

    func update(for colorScheme: ColorScheme) {
        // Call this when system appearance changes
        self.resolvedPalette = ColorPalette.themed(.rainbow, for: colorScheme)
    }
}
