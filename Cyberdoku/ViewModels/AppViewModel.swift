//
//  AppViewModel.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Foundation

@MainActor
class AppViewModel: ObservableObject {
    @Published var currentScreen: AppScreen = .mainMenu
    @Published var sudokuViewModel: SudokuViewModel?
    @Published var selectedDifficulty: PuzzleDifficulty = .easy
    @Published var selectedPuzzleIndex: Int? = nil

    func startNewGame(difficulty: PuzzleDifficulty, puzzleIndex: Int?) {
        guard let puzzle = PuzzleLoader.load(difficulty: difficulty, index: puzzleIndex) else {
            print("Failed to load puzzle for \(difficulty), index \(puzzleIndex ?? -1)")
            return
        }
        self.sudokuViewModel = SudokuViewModel(puzzle: puzzle)
        self.currentScreen = .play
    }
    func startNewGame() {
        self.sudokuViewModel = SudokuViewModel()
        self.currentScreen = .play
    }

    func resumeGame() {
        if let saved = GameStorage.load() {
            self.sudokuViewModel = SudokuViewModel(from: saved)
            self.currentScreen = .play
        }
    }

    func endGame() {
        self.sudokuViewModel = nil
        self.currentScreen = .mainMenu
    }
}
