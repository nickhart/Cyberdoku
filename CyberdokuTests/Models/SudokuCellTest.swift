//
//  SudokuCellTest.swift
//  CyberdokuTests
//
//  Created by Nick Hart on 6/29/25.
//

import Testing
@testable import Cyberdoku

struct SudokuCellTest {
    @Test
    func testTogglePositiveNoteAndIsPossible() {
        var cell = SudokuCell(value: 0, row: 0, col: 0, isOriginal: false)
        #expect(!cell.isPossible(3))

        cell.togglePositiveNote(3)
        #expect(cell.isPossible(3))
        #expect(cell.positiveNotes.contains(3))
        #expect(!cell.negativeNotes.contains(3))

        cell.togglePositiveNote(3)
        #expect(!cell.isPossible(3))
        #expect(!cell.positiveNotes.contains(3))
    }

    @Test
    func testToggleNegativeNoteAndIsExcluded() {
        var cell = SudokuCell(value: 0, row: 1, col: 1, isOriginal: false)
        #expect(!cell.isExcluded(7))

        cell.toggleNegativeNote(7)
        #expect(cell.isExcluded(7))
        #expect(cell.negativeNotes.contains(7))
        #expect(!cell.positiveNotes.contains(7))

        cell.toggleNegativeNote(7)
        #expect(!cell.isExcluded(7))
        #expect(!cell.negativeNotes.contains(7))
    }

    @Test
    func testTogglePositiveClearsNegative() {
        var cell = SudokuCell(value: 0, row: 2, col: 2, isOriginal: false)
        cell.toggleNegativeNote(5)
        #expect(cell.negativeNotes.contains(5))

        cell.togglePositiveNote(5)
        #expect(cell.positiveNotes.contains(5))
        #expect(!cell.negativeNotes.contains(5))
    }

    @Test
    func testToggleNegativeClearsPositive() {
        var cell = SudokuCell(value: 0, row: 3, col: 3, isOriginal: false)
        cell.togglePositiveNote(8)
        #expect(cell.positiveNotes.contains(8))

        cell.toggleNegativeNote(8)
        #expect(cell.negativeNotes.contains(8))
        #expect(!cell.positiveNotes.contains(8))
    }
}
