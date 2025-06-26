//
//  PuzzleLoaderTest.swift
//  CyberdokuTests
//
//  Created by Nick Hart on 6/26/25.
//

import Testing
@testable import Cyberdoku

struct PuzzleLoaderTests {
    @Test
    func loadsEasyPuzzleFromBundle() {
        let puzzle = PuzzleLoader.load(named: "easy")
        #expect(puzzle != nil)
        #expect(puzzle?.template.count == SudokuBoard.cellCount)
        #expect(puzzle?.template.allSatisfy { (0...9).contains($0) } == true)
    }

    @Test
    func failsToLoadMissingPuzzle() {
        let puzzle = PuzzleLoader.load(named: "not-a-puzzle")
        #expect(puzzle == nil)
    }
}
