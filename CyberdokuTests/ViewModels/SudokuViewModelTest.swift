//
//  SudokuViewModelTest.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Testing
@testable import Cyberdoku

struct SudokuViewModelTest {
    @Test func canSelectAndSetValue() async {
        let puzzle = Puzzle(title: "test", template: Array(repeating: 0, count: 81))
        let vm = await SudokuViewModel(puzzle: puzzle)

        await vm.selectCell(row: 0, col: 0)
        await vm.setValue(5)

        await #expect(vm.board.cells[0].value == 5)
    }

    @Test func cannotChangeOriginalValue() async {
        var template = Array(repeating: 0, count: 81)
        template[10] = 7
        let puzzle = Puzzle(title: "test", template: template)

        let vm = await SudokuViewModel(puzzle: puzzle)

        await vm.selectCell(row: 1, col: 1)
        await vm.setValue(4)

        await #expect(vm.board.cells[10].value == 7)
    }

    @Test func selectingUpdatesSelectedCell() async {
        let puzzle = Puzzle(title: "test", template: Array(repeating: 0, count: 81))

        let vm = await SudokuViewModel(puzzle: puzzle)

        await vm.selectCell(row: 3, col: 2)
        let selected = await vm.selectedCell

        #expect(selected?.row == 3)
        #expect(selected?.col == 2)
    }
}
