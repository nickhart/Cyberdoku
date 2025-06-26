//
//  RuleBasedAgent.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

struct RuleBasedAgent: Agent {
    let name: String = "Rule-Based Agent"
    let rules: [Rule]

    func nextMoves(for board: SudokuBoard) -> [Move] {
        for rule in rules {
            let moves = rule.apply(to: board)
            if !moves.isEmpty {
                return moves
            }
        }
        return []
    }
}

