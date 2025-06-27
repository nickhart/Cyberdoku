//
//  SudokuViewModel+GameState.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

extension SudokuViewModel {
    var currentState: GameState {
        return GameState(board: board, selectedCellIndex: selectedCellIndex, moveHistory: moveHistory, agentModifiedIndexes: agentModifiedIndexes, puzzle: puzzle)
    }

    func saveGame() {
        GameStorage.save(currentState)
    }

    static func loadSavedGame() -> SudokuViewModel? {
        guard let state = GameStorage.load() else { return nil }
        return SudokuViewModel(from: state)
    }

    convenience init(from state: GameState) {
        self.init(
            board: state.board,
            selectedCellIndex: state.selectedCellIndex,
            moveHistory: state.moveHistory,
            agentModifiedIndexes: state.agentModifiedIndexes,
            puzzle: state.puzzle
        )
    }
}
