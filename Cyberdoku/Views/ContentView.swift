//
//  ContentView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var appViewModel = AppViewModel()

    @ViewBuilder
    var body: some View {
        switch appViewModel.currentScreen {
        case .mainMenu:
            MainMenuView(appViewModel: appViewModel)

        case .newGame:
            NewGameView(appViewModel: appViewModel)

        case .resumeGame:
            Text("Resuming…") // or skip this and just go to `.play`

        case .settings:
            SettingsView(appViewModel: appViewModel)

        case .about:
            AboutView(appViewModel: appViewModel)

        case .play:
            // TODO: clean this up
            if let vm = appViewModel.sudokuViewModel {
                SudokuGameView(appViewModel: appViewModel, viewModel: vm)
            } else {
                Text("No game loaded.")
            }
        }
    }
}
