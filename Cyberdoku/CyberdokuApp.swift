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
    @StateObject private var appearance = AppearanceSettings(colorScheme: .light)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(preferences)
                .environmentObject(appearance)
                .onAppear {
                    appearance.update(for: colorScheme)
                }
                .onChange(of: colorScheme) { _, newScheme in
                    appearance.update(for: newScheme)
                }
        }
    }
}
