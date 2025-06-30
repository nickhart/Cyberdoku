//
//  SudokuBoardTest.swift
//  CyberdokuTests
//
//  Created by Nick Hart on 6/26/25.
//

import Testing
@testable import Cyberdoku

struct SudokuBoardTests {
    @Test
    func emptyBoardHas81Cells() {
        let board = SudokuBoard()
        #expect(board.cells.count == 81)
    }

    @Test
    func cellAccessByRowAndColumn() {
        let board = SudokuBoard()
        let cell = board.cellAt(row: 0, col: 0)
        #expect(cell.row == 0)
        #expect(cell.col == 0)
    }

    @Test
    func settingCellValueWorks() {
        var board = SudokuBoard()
        board.setValue(5, atRow: 0, col: 0)
        #expect(board.cellAt(row: 0, col: 0).value == 5)
    }

    @Test
    func boardIsValidInitially() {
        let board = SudokuBoard()
        #expect(board.isValid())
    }

    @Test
    func boardDetectsDuplicateInRow() {
        var board = SudokuBoard()
        board.setValue(1, atRow: 0, col: 0)
        board.setValue(1, atRow: 0, col: 1) // duplicate
        #expect(!board.isValid())
    }
    @Test
    func boardDetectsDuplicateInColumn() {
        var board = SudokuBoard()
        board.setValue(2, atRow: 0, col: 0)
        board.setValue(2, atRow: 1, col: 0) // duplicate
        #expect(!board.isValid())
    }

    @Test
    func boardDetectsDuplicateInBox() {
        var board = SudokuBoard()
        board.setValue(3, atRow: 0, col: 0)
        board.setValue(3, atRow: 1, col: 1) // both in top-left 3x3 box
        #expect(!board.isValid())
    }

    @Test
    func possibleValuesAreCorrect() {
        var board = SudokuBoard()
        board.setValue(1, atRow: 0, col: 0)
        board.setValue(2, atRow: 0, col: 1)
        board.setValue(3, atRow: 1, col: 0)
        let cell = board.cellAt(row: 1, col: 1)
        let possible = board.possibleValues(for: cell)
        #expect(!possible.contains(1))
        #expect(!possible.contains(2))
        #expect(!possible.contains(3))
        #expect(possible.contains(4))
    }

    @Test
    func cellsInRowColumnBoxReturnCorrectCount() {
        let board = SudokuBoard()
        #expect(board.cellsInRow(0).count == 9)
        #expect(board.cellsInColumn(0).count == 9)
        #expect(board.cellsInBox(startRow: 0, startCol: 0).count == 9)
    }

    @Test
    func boardValidAfterFixingConflict() {
        var board = SudokuBoard()
        board.setValue(5, atRow: 2, col: 2)
        board.setValue(5, atRow: 2, col: 3) // duplicate
        #expect(!board.isValid())

        board.setValue(0, atRow: 2, col: 3) // fix
        #expect(board.isValid())
    }

    @Test
    func boardIsSolvedReturnsTrueForValidCompleteBoard() {
        let values: [[Int]] = [
            [5,3,4,6,7,8,9,1,2],
            [6,7,2,1,9,5,3,4,8],
            [1,9,8,3,4,2,5,6,7],
            [8,5,9,7,6,1,4,2,3],
            [4,2,6,8,5,3,7,9,1],
            [7,1,3,9,2,4,8,5,6],
            [9,6,1,5,3,7,2,8,4],
            [2,8,7,4,1,9,6,3,5],
            [3,4,5,2,8,6,1,7,9]
        ]

        var board = SudokuBoard()
        for row in 0..<9 {
            for col in 0..<9 {
                board.setValue(values[row][col], atRow: row, col: col)
            }
        }

        #expect(board.isSolved())
    }
    
    @Test
    func boardIsSolvedFalseForIncompleteBoard() {
        let board = SudokuBoard()
        #expect(!board.isSolved())
    }
}
