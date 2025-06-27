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
    let puzzle: [Int]
    let agent = RuleBasedAgent(rules: [NakedSingleRule()])
    
    init(puzzle: [Int]) {
        self.puzzle = puzzle
        self.board = SudokuBoard(template: puzzle)
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
        board = SudokuBoard(template: puzzle)
        moveHistory = []
        selectedCellIndex = nil
        agentModifiedIndexes.removeAll()
    }
}
