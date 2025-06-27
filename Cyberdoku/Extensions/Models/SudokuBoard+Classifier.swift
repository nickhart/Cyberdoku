//
//  SudokuBoard+Classification.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

extension SudokuBoard {
    func allUnits() -> [[SudokuCell]] {
        var units: [[SudokuCell]] = []

        for i in 0..<Self.gridSize {
            units.append(cellsInRow(i))
            units.append(cellsInColumn(i))
        }

        for boxRow in 0..<3 {
            for boxCol in 0..<3 {
                units.append(cellsInBox(startRow: boxRow * 3, startCol: boxCol * 3))
            }
        }

        return units
    }
}
