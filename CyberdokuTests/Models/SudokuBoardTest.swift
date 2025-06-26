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
}
