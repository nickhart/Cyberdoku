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
}
