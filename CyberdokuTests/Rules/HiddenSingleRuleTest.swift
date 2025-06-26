//
//  HiddenSingleRuleTest.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//



import Testing
@testable import Cyberdoku

struct HiddenSingleRuleTest {
    @Test
    func detectsHiddenSingleInRow() {
        var board = SudokuBoard()
        
        // Fill row 0 with all numbers except 9
        for col in 0..<8 {
            board.setValue(col + 1, atRow: 0, col: col)
        }
        
        // Do NOT place a 9 elsewhere in column 8 — we want it to be the only option in row 0
        // board.setValue(9, atRow: 1, col: 8) // REMOVE this line
        
        let rule = HiddenSingleRule()
        let moves = rule.apply(to: board)
        
        #expect(moves.count == 1)
        let move = moves[0]
        let row = move.index / 9
        let col = move.index % 9
        #expect(row == 0)
        #expect(col == 8)
        #expect(move.value == 9)
        #expect(move.reason == .hiddenSingle)
    }
    @Test
    func detectsHiddenSingleInColumn() {
        var board = SudokuBoard()
        
        // Fill column 0 with all numbers except 9
        for row in 0..<8 {
            board.setValue(row + 1, atRow: row, col: 0)
        }

        let rule = HiddenSingleRule()
        let moves = rule.apply(to: board)

        #expect(moves.count == 1)
        let move = moves[0]
        let row = move.index / 9
        let col = move.index % 9
        #expect(row == 8)
        #expect(col == 0)
        #expect(move.value == 9)
        #expect(move.reason == .hiddenSingle)
    }

    @Test
    func detectsHiddenSingleInBox() {
        var board = SudokuBoard()
        
        // Fill top-left 3x3 box with all values except 9
        var inserted = 1
        for row in 0..<3 {
            for col in 0..<3 {
                if inserted == 9 { continue }
                if row == 2 && col == 2 { continue }
                board.setValue(inserted, atRow: row, col: col)
                inserted += 1
            }
        }

        let rule = HiddenSingleRule()
        let moves = rule.apply(to: board)

        #expect(moves.count == 1)
        let move = moves[0]
        let row = move.index / 9
        let col = move.index % 9
        #expect(row == 2)
        #expect(col == 2)
        #expect(move.value == 9)
        #expect(move.reason == .hiddenSingle)
    }

    @Test
    func detectsNoHiddenSingles() {
        let board = SudokuBoard() // Completely empty board

        let rule = HiddenSingleRule()
        let moves = rule.apply(to: board)

        #expect(moves.isEmpty)
    }
}
