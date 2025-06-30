//
//  SudokuViewModel.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Foundation
import SwiftUI

// At top of SudokuViewModel.swift, outside the class
enum GameMode {
    case play
    case note
    case training
}

@MainActor
class SudokuViewModel: ObservableObject {
    @Published var board: SudokuBoard
    @Published var selectedCellIndex: Int? = nil
    @Published var moveHistory: [SudokuBoard] = []
    @Published var agentModifiedIndexes: Set<Int> = []
    @Published var mode: GameMode = .play
    let puzzle: Puzzle
    let agent = RuleBasedAgent(rules: [NakedSingleRule()])
    
    init(puzzle: Puzzle? = nil) {
        self.puzzle = puzzle ?? Puzzle.empty
        self.board = SudokuBoard(template: self.puzzle.template)
    }

    init(board: SudokuBoard, selectedCellIndex: Int?, moveHistory: [SudokuBoard], agentModifiedIndexes: Set<Int>, puzzle: Puzzle? = nil) {
        self.board = board
        self.selectedCellIndex = selectedCellIndex
        self.moveHistory = moveHistory
        self.agentModifiedIndexes = agentModifiedIndexes
        self.puzzle = puzzle ?? Puzzle.empty
    }

    var selectedCell: SudokuCell? {
        guard let index = selectedCellIndex else { return nil }
        return board.cells[index]
    }

    // MARK: - Training Data Capture Methods

    func startCapture() {
        print("🟡 Starting training data capture...")
        // TODO: Clear any previous selection state if needed
    }

    func cancelCapture() {
        print("🔴 Training data capture cancelled.")
        // TODO: Reset capture-related UI or state
    }

    func saveCapture() {
        print("🟢 Saving captured training example...")
        // TODO: Build TrainingExample struct and persist it
    }

    func addPositiveNote(_ value: Int) {
        guard let index = selectedCellIndex, board.cells[index].value == 0 else { return }
        if board.cells[index].positiveNotes.contains(value) {
            board.cells[index].positiveNotes.remove(value)
        } else {
            board.cells[index].positiveNotes.insert(value)
        }
        board.cells[index].negativeNotes.remove(value)
    }

    func addNegativeNote(_ value: Int) {
        guard let index = selectedCellIndex, board.cells[index].value == 0 else { return }
        if board.cells[index].negativeNotes.contains(value) {
            board.cells[index].negativeNotes.remove(value)
        } else {
            board.cells[index].negativeNotes.insert(value)
        }
        board.cells[index].positiveNotes.remove(value)
    }

    var remainingCounts: [Int] {
        board.remainingCounts()
    }

    func selectCell(row: Int, col: Int) {
        selectedCellIndex = row * 9 + col
    }

    func setValue(_ value: Int) {
        guard let index = selectedCellIndex else { return }
        guard !board.cells[index].isOriginal else { return }
        moveHistory.append(board)
        board.cells[index].value = value
        agentModifiedIndexes.removeAll()
    }
    
    func undoLastMove() {
        if moveHistory.count > 0 {
            board = moveHistory.removeLast()
            // UX question: deselect the cell? or select the prior move? TBD...
            agentModifiedIndexes.removeAll()
        }
    }
    
    func resetPuzzle() {
        board = SudokuBoard(template: puzzle.template)
        moveHistory = []
        selectedCellIndex = nil
        agentModifiedIndexes.removeAll()
    }
    
    // Automatically fill in possible notes for empty cells, optionally including negative notes
    func autoNote(mode: NoteMode = .positiveOnly) {
        for idx in 0..<board.cells.count where board.cells[idx].value == 0 {
            let row = board.cells[idx].row
            let col = board.cells[idx].col
            board.cells[idx].positiveNotes = []
            board.cells[idx].negativeNotes = []

            for n in 1...9 {
                if board.isValid(n, atRow: row, col: col) {
                    board.cells[idx].positiveNotes.insert(n)
                } else if mode == .positiveAndNegative {
                    board.cells[idx].negativeNotes.insert(n)
                }
            }
#if DEBUG
            if board.cells[idx].positiveNotes.rawValue & board.cells[idx].negativeNotes.rawValue != 0 {
                print("⚠️ Note conflict in cell (\(row), \(col)): both positive and negative set for some value(s)")
            }
#endif
        }
    }
}
