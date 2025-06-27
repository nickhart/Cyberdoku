//
//  NewGameView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var preferences: AppPreferences
    @EnvironmentObject var appearance: AppearanceSettings
    @ObservedObject var appViewModel: AppViewModel
    @State private var selectedDifficulty: PuzzleDifficulty = .easy
    @State private var selectedPuzzleIndex: Int = 1

    var body: some View {
        VStack(spacing: 16) {
            Text("New Game")
                .font(.largeTitle)

            Picker("Difficulty", selection: $selectedDifficulty) {
                ForEach(PuzzleDifficulty.allCases) { difficulty in
                    Text(difficulty.rawValue.capitalized).tag(difficulty)
                }
            }
            .pickerStyle(.segmented)

            Stepper(value: $selectedPuzzleIndex, in: 1...999) {
                Text("Puzzle #\(selectedPuzzleIndex)")
            }

            Button("Start Game") {
                appViewModel.startNewGame(difficulty: selectedDifficulty, puzzleIndex: selectedPuzzleIndex)
            }
            .buttonStyle(.borderedProminent)

            Button("Back") {
                appViewModel.currentScreen = .mainMenu
            }
            .padding(.top)
        }
        .padding()
    }
}
