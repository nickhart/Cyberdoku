//
//  RuleEngine.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

class RuleEngine {
    let rules: [Rule]

    init(rules: [Rule]) {
        self.rules = rules
    }

    func suggestMoves(for board: SudokuBoard) -> [Move] {
        for rule in rules {
            let moves = rule.apply(to: board)
            if !moves.isEmpty {
                return moves
            }
        }
        return []
    }
}

