//
//  AppearanceSettings.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/27/25.
//


import SwiftUI

final class AppearanceSettings: ObservableObject {
    @Published var selectedPalette: String
    @Published var resolvedPalette: ColorPalette

    init(colorScheme: ColorScheme = .light, selectedPalette: String? = nil) {
        let paletteName = selectedPalette ?? "Default Accessible"
        self.selectedPalette = paletteName
        self.resolvedPalette = ColorPalette.named(paletteName, for: colorScheme)
    }

    func update(for colorScheme: ColorScheme, selectedPalette: String? = nil) {
        let paletteName = selectedPalette ?? "Default Accessible"
        self.selectedPalette = paletteName
        self.resolvedPalette = ColorPalette.named(paletteName, for: colorScheme)
    }
}
