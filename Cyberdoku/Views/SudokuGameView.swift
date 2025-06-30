//
//  SudokuGameView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

extension View {
    func styledButton(color: Color = .blue.opacity(0.1)) -> some View {
        self
            .padding()
            .background(color)
            .cornerRadius(8)
    }
}

struct SudokuGameView: View {
    @EnvironmentObject var preferences: AppPreferences
    @EnvironmentObject var appearance: AppearanceSettings
    @ObservedObject var appViewModel: AppViewModel
    @ObservedObject var viewModel: SudokuViewModel
    @State private var showResetConfirmation = false
    @State private var showSolvedConfirmation: Bool = false
    @State private var agentUsed: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var statusMessage: String = ""
    
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
                            statusMessage = ""
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
                    statusMessage = "Applied AI move using rule-based agent."
                    showSolvedConfirmation = viewModel.board.isSolved()
                }
                .styledButton()
                Button("Try Classifier") {
                    agentUsed = true
                    let classifier = MLMoveClassifier()
                    let boardValues = viewModel.board.cells.map(\.value)
                    if let prediction = classifier.classify(board: boardValues) {
                        statusMessage = "Classifier predicts: \(prediction)"
                    } else {
                        statusMessage = "Classifier could not determine a move."
                    }
                }
                .styledButton()
                Spacer()
            }
            HStack {
                Spacer()
                Button("Reset") {
                    showResetConfirmation = true
                    statusMessage = ""
                }
                .styledButton()
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
                    statusMessage = "Last move undone."
                }
                .styledButton()
                .disabled(viewModel.moveHistory.isEmpty)
                Spacer()
                Button("Exit") {
                    GameStorage.save(viewModel.currentState)
                    appViewModel.currentScreen = .mainMenu
                }
                .styledButton(color: .red.opacity(0.1))
                Spacer()
            }
            HStack {
                Spacer()
                Button("Auto-Note") {
                    viewModel.autoNote()
                    statusMessage = "Candidate notes updated."
                }
                .styledButton()
                Spacer()
            }
            // Note-taking controls
            if viewModel.mode == GameMode.note {
                HStack {
                    Text("Note mode:")
                    ForEach(1...9, id: \.self) { n in
                        Button("+\(n)") {
                            viewModel.addPositiveNote(n)
                        }
                        .styledButton()

                        Button("-\(n)") {
                            viewModel.addNegativeNote(n)
                        }
                        .styledButton(color: .red.opacity(0.1))
                    }
                }
                .padding(.horizontal)
            }

            // Training controls
            if viewModel.mode == GameMode.training {
                HStack {
                    Text("Training mode:")
                    Button("Start Capture") { viewModel.startCapture() }.styledButton()
                    Button("Cancel") { viewModel.cancelCapture() }.styledButton(color: .red.opacity(0.1))
                    Button("Save") { viewModel.saveCapture() }.styledButton(color: .green.opacity(0.1))
                }
                .padding(.horizontal)
            }

            HStack {
                Text(statusMessage.isEmpty ? " " : statusMessage)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(statusMessage.isEmpty ? Color.clear : Color.yellow.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    let puzzle = PuzzleLoader.load(difficulty: .easy)
    let viewModel = SudokuViewModel(puzzle: puzzle ?? Puzzle.empty)
    let appViewModel = AppViewModel()
    let appearance = AppearanceSettings()

    SudokuGameView(appViewModel: appViewModel, viewModel: viewModel)
        .environmentObject(appearance)
}
