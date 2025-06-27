//
//  BoardView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct SudokuBoardView: View {
//    @EnvironmentObject var preferences: AppPreferences
    @EnvironmentObject var appearance: AppearanceSettings
    @ObservedObject var viewModel: SudokuViewModel
    
    func cellBackgroundColor(_ cell: SudokuCell) -> Color {
        return appearance.resolvedPalette.cellBackground
    }

    func cellBorderColor(_ cell: SudokuCell) -> Color {
        return appearance.resolvedPalette.borderColor
    }

    func cellTextColor(_ cell: SudokuCell) -> Color {
        return appearance.resolvedPalette.color(for: cell.value)
    }
    
    func isShadedBox(row: Int, col: Int) -> Bool {
        let boxRow = row / 3
        let boxCol = col / 3
        return (boxRow + boxCol) % 2 == 1
    }
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<9, id: \.self) { col in
                        let index = row * 9 + col
                        let cell = viewModel.board.cells[index]
                        let isModified = viewModel.agentModifiedIndexes.contains(index)
                        CellView(
                            cell: cell,
                            isAgentModified: isModified,
                            row: row,
                            col: col,
                            onSelect: {
                                viewModel.selectCell(row: row, col: col)
                            },
                            isShaded: isShadedBox(row: row, col: col)
                        )
                    }
                }
            }
        }
        .padding()
    }
}

struct SudokuBoardView_Previews: PreviewProvider {
    static var previews: some View {
        let puzzle = PuzzleLoader.load(difficulty: .easy)
        let vm = SudokuViewModel(puzzle: puzzle ?? Puzzle.empty)
        
        SudokuBoardView(viewModel: vm)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
