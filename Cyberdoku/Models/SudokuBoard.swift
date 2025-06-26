//
//  SudokuBoard.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

struct SudokuBoard {
    static let gridSize = 9
    static let cellCount = gridSize * gridSize
    
    var cells: [SudokuCell]
    
    init(template: [Int]? = nil) {
        let values = template ?? Array(repeating: 0, count: Self.cellCount)
        
        precondition(values.count == Self.cellCount, "Template must have exactly \(Self.cellCount) values")
        precondition(values.allSatisfy { (0...9).contains($0) }, "Template values must be in range 0...9")
        
        self.cells = (0..<Self.cellCount).map { i in
            let row = i / 9
            let col = i % 9
            let value = values[i]
            let isOriginal = value != 0
            
            return SudokuCell(value: value, row: row, col: col, isOriginal: isOriginal)
        }
    }
    
    func isValid() -> Bool {
        // Validate all rows
        for row in 0..<Self.gridSize {
            let values = cellsInRow(row).map(\.value).filter { $0 != 0 }
            if hasDuplicates(values) { return false }
        }
        
        // Validate all columns
        for col in 0..<Self.gridSize {
            let values = cellsInColumn(col).map(\.value).filter { $0 != 0 }
            if hasDuplicates(values) { return false }
        }
        
        // Validate all 3x3 boxes
        for boxRow in 0..<3 {
            for boxCol in 0..<3 {
                let values = cellsInBox(boxRow: boxRow, boxCol: boxCol).map(\.value).filter { $0 != 0 }
                if hasDuplicates(values) { return false }
            }
        }
        
        return true
    }
    
    func index(row: Int, col: Int) -> Int {
        return row * 9 + col
    }
    
    func cellAt(row: Int, col: Int) -> SudokuCell {
        return cells[index(row: row, col: col)]
    }
    
    mutating func setValue(_ value: Int, atRow row: Int, col: Int) {
        let idx = index(row: row, col: col)
        cells[idx].value = value
    }
    
    mutating func toggleNote(_ note: Int, atRow row: Int, col: Int) {
        let idx = index(row: row, col: col)
        if cells[idx].notes.contains(note) {
            cells[idx].notes.remove(note)
        } else {
            cells[idx].notes.insert(note)
        }
    }

    private func cellsInRow(_ row: Int) -> [SudokuCell] {
        cells.filter { $0.row == row }
    }

    private func cellsInColumn(_ col: Int) -> [SudokuCell] {
        cells.filter { $0.col == col }
    }

    private func cellsInBox(boxRow: Int, boxCol: Int) -> [SudokuCell] {
        let startRow = boxRow * 3
        let startCol = boxCol * 3

        return cells.filter {
            ($0.row >= startRow && $0.row < startRow + 3) &&
            ($0.col >= startCol && $0.col < startCol + 3)
        }
    }

    private func hasDuplicates(_ values: [Int]) -> Bool {
        Set(values).count != values.count
    }
}

