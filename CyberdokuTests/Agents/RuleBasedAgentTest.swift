//
//  RuleBasedAgentTest.swift
//  CyberdokuTests
//
//  Created by Nick Hart on 6/26/25.
//

import Testing

@testable import Cyberdoku

struct RuleBasedAgentTest {
    @Test
    func findsNakedSingleMove() {
        // Create a board with a naked single at index 0
        var template = Array(repeating: 0, count: 81)
        // Fill all cells in row 0, column 0, and box 0 except one
        for i in 1..<9 {
            template[i] = i // row 0
            template[i * 9] = i // column 0
        }
        // Remove duplicated values for accuracy
        template[0] = 0
        template[10] = 0
        template[18] = 0

        let board = SudokuBoard(template: template)
        let rule = NakedSingleRule()
        let agent = RuleBasedAgent(rules: [rule])
        let moves = agent.nextMoves(for: board)

        #expect(!moves.isEmpty)
        #expect(moves.contains { $0.index == 0 && $0.value == 9 })
    }
}
