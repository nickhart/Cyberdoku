//
//  SudokuBoardSerializationTest.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Testing
@testable import Cyberdoku

struct SudokuBoardSerializationTest {
    @Test func serializedValues_matchTemplate() {
        let template = Array(repeating: 0, count: SudokuBoard.cellCount)
        let board = SudokuBoard(template: template)
        
        #expect(board.serializedValues == template)
    }

    @Test func serializedPossibilities_matchBoardState() {
        var template = Array(repeating: 0, count: SudokuBoard.cellCount)
        template[0] = 1
        template[1] = 2
        template[2] = 3

        let board = SudokuBoard(template: template)
        let possibilities = board.serializedPossibilities

        // The first 3 should be empty, since they are filled
        #expect(possibilities[0].isEmpty)
        #expect(possibilities[1].isEmpty)
        #expect(possibilities[2].isEmpty)

        // The 4th cell should not contain 1, 2, or 3
        #expect(!possibilities[3].contains(1))
        #expect(!possibilities[3].contains(2))
        #expect(!possibilities[3].contains(3))
    }

    @Test func aiPayload_hasCorrectKeys() {
        let board = SudokuBoard()
        let payload = board.aiPayload

        let keys = Array(payload.keys)
        #expect(keys.contains("values"))
        #expect(keys.contains("possibilities"))
    }

    @Test func aiPayloadJSON_serializesSuccessfully() throws {
        let board = SudokuBoard()
        let json = try board.aiPayloadJSON()
        #expect(!json.isEmpty)
    }
}
