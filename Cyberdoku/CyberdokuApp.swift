//
//  CyberdokuApp.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

@main
struct CyberdokuApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var preferences = AppPreferences()
    @StateObject private var appearance = AppearanceSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(preferences)
                .environmentObject(appearance)
                .onAppear {
                    appearance.update(for: colorScheme, selectedPalette: AppPreferences.colorPalette)
                }
                .onChange(of: colorScheme) { _, newScheme in
                    appearance.update(for: newScheme, selectedPalette: AppPreferences.colorPalette)
                }
        }
    }
}
