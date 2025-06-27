//
//  SettingsView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var preferences: AppPreferences
    @EnvironmentObject var appearance: AppearanceSettings
    @ObservedObject var appViewModel: AppViewModel
    @State private var selectedDifficulty = AppPreferences.defaultDifficulty
    @State private var selectedPalette = AppPreferences.colorPalette ?? ColorPalette.all.first?.name ?? ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Settings")
                .font(.largeTitle)
                .bold()

            Picker("Default Difficulty", selection: $selectedDifficulty) {
                ForEach(PuzzleDifficulty.allCases, id: \.self) { difficulty in
                    Text(difficulty.rawValue.capitalized).tag(difficulty)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedDifficulty) { _, newValue in
                AppPreferences.defaultDifficulty = newValue
            }

            Picker("Color Palette", selection: $selectedPalette) {
                ForEach(ColorPalette.all.map(\.name), id: \.self) { palette in
                    Text(palette).tag(palette)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedPalette) { _, newValue in
                AppPreferences.colorPalette = newValue
            }

            Button("Back") {
                appViewModel.currentScreen = .mainMenu
            }
        }
        .padding()
    }
}
