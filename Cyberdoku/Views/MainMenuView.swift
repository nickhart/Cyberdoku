//
//  MainMenuView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var preferences: AppPreferences
    @EnvironmentObject var appearance: AppearanceSettings
    @ObservedObject var appViewModel: AppViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("Cyberdoku")
                .font(.largeTitle)
                .bold()

            Button("New Game") {
                appViewModel.currentScreen = .newGame
            }

            Button("Resume Game") {
                appViewModel.resumeGame()
            }

            Button("Settings") {
                appViewModel.currentScreen = .settings
            }

            Button("About") {
                appViewModel.currentScreen = .about
            }
        }
        .padding()
    }
}
