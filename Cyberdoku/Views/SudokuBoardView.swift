//
//  BoardView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import SwiftUI

struct SudokuBoardView: View {
    @ObservedObject var viewModel: SudokuViewModel
    
    func cellBackgroundColor(_ cell: SudokuCell) -> Color {
        if cell.isOriginal {
            return Color.gray
        } else if viewModel.selectedCellIndex == (cell.row * 9 + cell.col) {
            return Color.cyan.opacity(0.5)
        } else {
            return Color.clear
        }
    }
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<9, id: \.self) { col in
                        let index = row * 9 + col
                        let cell = viewModel.board.cells[index]
                        let isAgentModified = viewModel.agentModifiedIndexes.contains(index)
                        Button(action: {
                            viewModel.selectCell(row: row, col: col)
                        }) {
                            Text(cell.value > 0 ? "\(cell.value)" : "")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .background(isAgentModified ? Color.green.opacity(0.3) : cellBackgroundColor(cell))
                                .border(Color.black)
                                .contentShape(Rectangle()) // Ensures the full frame is tappable
                        }
                        .disabled(cell.isOriginal)
                        .buttonStyle(PlainButtonStyle()) // Prevents weird padding/styling
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
