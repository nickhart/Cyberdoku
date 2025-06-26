//
//  NakedSingleRule.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

struct NakedSingleRule: Rule {
    let name = "Naked Single"

    func apply(to board: SudokuBoard) -> [Move] {
        board.cells.enumerated().compactMap { index, cell in
            let possible = board.possibleValues(for: cell)
            if cell.value == 0 && possible.count == 1 {
                return Move(index: index, value: possible.first!, reason: MoveReason.nakedSingle)
            }
            return nil
        }
    }
}

