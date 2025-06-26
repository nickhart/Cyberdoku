//
//  NakedSingleRuleTest.swift
//  CyberdokuTests
//
//  Created by Nick Hart on 6/26/25.
//

import Testing
@testable import Cyberdoku

struct NakedSingleRuleTest {

    @Test func appliesNakedSingleMove() async throws {
        // Create a board with one cell having only one possible value
        var board = SudokuBoard()
        board.setValue(1, atRow: 0, col: 1)
        board.setValue(2, atRow: 0, col: 2)
        board.setValue(3, atRow: 0, col: 3)
        board.setValue(4, atRow: 0, col: 4)
        board.setValue(5, atRow: 0, col: 5)
        board.setValue(6, atRow: 0, col: 6)
        board.setValue(7, atRow: 0, col: 7)
        board.setValue(8, atRow: 0, col: 8)

        let rule = NakedSingleRule()
        let moves = rule.apply(to: board)

        // Only one possible value (9) should remain for (0, 0)
        #expect(moves.count == 1)
        #expect(moves[0].index == 0)
        #expect(moves[0].value == 9)
    }

    @Test func noMoveIfNoNakedSingle() async throws {
        let board = SudokuBoard()
        let rule = NakedSingleRule()
        let moves = rule.apply(to: board)

        #expect(moves.isEmpty)
    }
}
