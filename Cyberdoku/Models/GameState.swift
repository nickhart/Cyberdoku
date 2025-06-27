//
//  GameState.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


struct GameState: Codable {
    var board: SudokuBoard
    var selectedCellIndex: Int?
    var moveHistory: [SudokuBoard]
    var agentModifiedIndexes: Set<Int> = []
    var puzzle: Puzzle?
}
