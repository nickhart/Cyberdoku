//
//  SudokuViewModel+Agent.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

extension SudokuViewModel {
    func applyAgentMoves() {
        let moves = agent.nextMoves(for: board)
        guard !moves.isEmpty else { return }
        moveHistory.append(board)
        
        agentModifiedIndexes = Set(moves.map { $0.index })

        for move in moves {
            let row = move.index / 9
            let col = move.index % 9
            board.setValue(move.value, atRow: row, col: col)
        }
    }
}
