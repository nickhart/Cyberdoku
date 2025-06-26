//
//  ContentView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: SudokuViewModel

    init() {
        let puzzle = PuzzleLoader.load(named: "easy")
        _viewModel = StateObject(wrappedValue: SudokuViewModel(puzzle: puzzle?.template ?? Array(repeating: 0, count: 81)))
    }

    var body: some View {
        VStack {
            SudokuBoardView(viewModel: viewModel)

            HStack {
                ForEach(1..<10) { n in
                    Button("\(n)") {
                        viewModel.setValue(n)
                    }
                    .frame(width: 32, height: 32)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
