//
//  BoardView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import SwiftUI

struct SudokuBoardView: View {
    @ObservedObject var viewModel: SudokuViewModel

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<9, id: \.self) { col in
                        let index = row * 9 + col
                        let cell = viewModel.board.cells[index]
                        Text(cell.value == 0 ? "" : "\(cell.value)")
                            .frame(width: 36, height: 36)
                            .background(viewModel.selectedCellIndex == index ? Color.blue.opacity(0.3) : Color.white)
                            .border(Color.gray)
                            .onTapGesture {
                                viewModel.selectCell(row: row, col: col)
                            }
                    }
                }
            }
        }
        .padding()
    }
}

struct SudokuBoardView_Previews: PreviewProvider {
    static var previews: some View {
        let puzzle = PuzzleLoader.load(named: "easy")
        let vm = SudokuViewModel(puzzle: puzzle?.template ?? Array(repeating: 0, count: 81))

        SudokuBoardView(viewModel: vm)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
