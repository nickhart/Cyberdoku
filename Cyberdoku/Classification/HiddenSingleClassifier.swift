//
//  HiddenSingleClassifier.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

struct HiddenSingleClassifier: MoveClassifier {
    func classify(board: SudokuBoard) -> [Move] {
        var moves: [Move] = []

        for unit in board.allUnits() {
            // For each digit, count occurrences
            var valueToCells: [Int: [SudokuCell]] = [:]

            for cell in unit where cell.value == 0 {
                let possibilities = board.possibleValues(for: cell)
                for value in possibilities {
                    valueToCells[value, default: []].append(cell)
                }
            }

            for (value, cells) in valueToCells {
                if cells.count == 1, let target = cells.first {
                    let index = target.row * 9 + target.col
                    moves.append(Move(index: index, value: value, reason: .hiddenSingle))
                }
            }
        }

        return moves
    }
}
