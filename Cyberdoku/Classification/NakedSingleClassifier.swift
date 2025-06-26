//
//  NakedSingleClassifier.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


struct NakedSingleClassifier: MoveClassifier {
    func classify(board: SudokuBoard) -> [Move] {
        board.cells.enumerated().compactMap { index, cell in
            guard cell.value == 0 else { return nil }
            let possibles = board.possibleValues(for: cell)
            if possibles.count == 1 {
                return Move(index: index, value: possibles[0], reason: .nakedSingle)
            } else {
                return nil
            }
        }
    }
}
