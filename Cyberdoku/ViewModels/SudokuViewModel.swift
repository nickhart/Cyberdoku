//
//  SudokuViewModel.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Foundation
import SwiftUI

@MainActor
class SudokuViewModel: ObservableObject {
    @Published var board: SudokuBoard
    @Published var selectedCellIndex: Int? = nil
    @Published var moveHistory: [SudokuBoard] = []
    @Published var agentModifiedIndexes: Set<Int> = []
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
}
