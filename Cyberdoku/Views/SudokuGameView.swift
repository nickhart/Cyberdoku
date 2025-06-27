//
//  SudokuGameView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct SudokuGameView: View {
    @ObservedObject var appViewModel: AppViewModel
    @ObservedObject var viewModel: SudokuViewModel
    @State private var showResetConfirmation = false
    @State private var showSolvedConfirmation: Bool = false
    @State private var agentUsed: Bool = false
    @Environment(\.dismiss) private var dismiss

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
                Text("\(agentUsed ? "We" : "You") solved the puzzle!")
            }
            .padding()
            HStack {
                Spacer()
                Button("Apply AI Move") {
                    agentUsed = true
                    viewModel.applyAgentMoves()
                    showSolvedConfirmation = viewModel.board.isSolved()
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
                Button("Try Classifier") {
                    agentUsed = true
                    let classifier = MLMoveClassifier()
                    let boardValues = viewModel.board.cells.map(\.value)
                    if let prediction = classifier.classify(board: boardValues) {
                        print("Predicted move type: \(prediction)")
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
                Spacer()
            }
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
                Button("Exit") {
                    GameStorage.save(viewModel.currentState)
                    appViewModel.currentScreen = .mainMenu
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
                Spacer()
            }
        }
    }
}

#Preview {
    let puzzle = PuzzleLoader.load(difficulty: .easy)
    let viewModel = SudokuViewModel(puzzle: puzzle ?? Puzzle.empty)
    let appViewModel = AppViewModel()

    SudokuGameView(appViewModel: appViewModel, viewModel: viewModel)
}
