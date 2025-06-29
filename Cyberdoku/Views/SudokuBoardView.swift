//
//  BoardView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct SudokuBoardView: View {
    static let innerSpacing: CGFloat = 1
    static let outerSpacing: CGFloat = 4
    
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
        VStack(spacing: Self.outerSpacing) {
            ForEach(0..<3, id: \.self) { boxRow in
                HStack(spacing: Self.outerSpacing) {
                    ForEach(0..<3, id: \.self) { boxCol in
                        // TODO: refactor this into SudokuBoxView
                        VStack(spacing: Self.innerSpacing) {
                            ForEach(0..<3, id: \.self) { cellRow in
                                HStack(spacing: Self.innerSpacing) {
                                    ForEach(0..<3, id: \.self) { cellCol in
                                        let row = boxRow * 3 + cellRow
                                        let col = boxCol * 3 + cellCol
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
                                        .aspectRatio(1, contentMode: .fit)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(Self.outerSpacing)
    }
}

struct SudokuBoardView_Previews: PreviewProvider {
    static var previews: some View {
        let puzzle = PuzzleLoader.load(difficulty: .easy)
        let viewModel = SudokuViewModel(puzzle: puzzle ?? Puzzle.empty)
        let appearance = AppearanceSettings()
        
        SudokuBoardView(viewModel: viewModel)
            .environmentObject(appearance)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
