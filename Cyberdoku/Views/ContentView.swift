//
//  ContentView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SudokuViewModel
    @State private var showResetConfirmation = false
    @State var showSolvedConfirmation: Bool = false

    init() {
        let puzzle = PuzzleLoader.load(named: "easy")
        _viewModel = StateObject(wrappedValue: SudokuViewModel(puzzle: puzzle?.template ?? Array(repeating: 0, count: 81)))
    }

    var body: some View {
        VStack {
            SudokuBoardView(viewModel: viewModel)

            HStack {
                ForEach(1..<10) { n in
                    VStack {
                        // Visualization: e.g., dots or hash marks
                        VStack(spacing: 1) {
                            ForEach(0..<viewModel.remainingCounts[n - 1], id: \.self) { _ in
                                Rectangle()
                                    .frame(width: 10, height: 2)
                            }
                        }
                        .frame(width: 32, height: 12, alignment: .bottom)
                        
                        Button("\(n)") {
                            viewModel.setValue(n)
                            showSolvedConfirmation = viewModel.board.isSolved()
                        }
                        .frame(width: 32, height: 32)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                        .disabled(viewModel.remainingCounts[n - 1] == 0)
                    }
                }
            }
            .alert("Congratulations!", isPresented: $showSolvedConfirmation) {
                Button("Done", role: .cancel) { }
            } message: {
                Text("You solved the puzzle!")
            }
            .padding()
            HStack {
                Spacer()
                Button("Reset") {
                    showResetConfirmation = true
                }
                .disabled(viewModel.moveHistory.isEmpty)
                .alert("Reset Puzzle?", isPresented: $showResetConfirmation) {
                    Button("Reset", role: .destructive) {
                        viewModel.resetPuzzle()
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to reset the puzzle? This will erase all your changes.")
                }
                Spacer()
                Button("Undo") {
                    viewModel.undoLastMove()
                }
                .disabled(viewModel.moveHistory.isEmpty)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
