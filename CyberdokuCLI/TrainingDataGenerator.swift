//
//  TrainingDataGenerator.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

let easyTemplate: [Int] = [
    0, 0, 0, 2, 6, 0, 7, 0, 1,
    6, 8, 0, 0, 7, 0, 0, 9, 0,
    1, 9, 0, 0, 0, 4, 5, 0, 0,
    8, 2, 0, 1, 0, 0, 0, 4, 0,
    0, 0, 4, 6, 0, 2, 9, 0, 0,
    0, 5, 0, 0, 0, 3, 0, 2, 8,
    0, 0, 9, 3, 0, 0, 0, 7, 4,
    0, 4, 0, 0, 5, 0, 0, 3, 6,
    7, 0, 3, 0, 1, 8, 0, 0, 0
]

enum TrainingDataGenerator {
    static func generateTrainingData(from puzzleURL: URL, outputURL: URL) throws {
        var rows: [[String]] = []
        let agent = RuleBasedAgent(rules: [NakedSingleRule(), HiddenSingleRule()])
        let templates = try TrainingDataGenerator.readPuzzleTemplates(from: puzzleURL)

        print("found \(templates.count) templates\n")
        var index = 0
        for template in templates {
            index += 1
            print("\(index)")
            var board = SudokuBoard(template: template)

            while let move = agent.nextMoves(for: board).first {
                let boardRow = board.cells.map { String($0.value) }
                let label = String(describing: move.reason)
                rows.append(boardRow + [label])

                let row = move.index / 9
                let col = move.index % 9
                board.setValue(move.value, atRow: row, col: col)
            }
            
            // also put in a negative when we run out of moves to classify
            let boardRow = board.cells.map { String($0.value) }
            rows.append(boardRow + ["none"])
        }

        let header = (0..<81).map { "cell_\($0)" } + ["label"]
        let csvString = ([header] + rows).map { $0.joined(separator: ",") }.joined(separator: "\n")
        try csvString.write(to: outputURL, atomically: true, encoding: .utf8)
    }
    
    static func readPuzzleTemplates(from inputURL: URL) throws -> [[Int]] {
        let content = try String(contentsOf: inputURL, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }

        return lines.compactMap { line in
            let values = line.components(separatedBy: ",").compactMap { Int($0) }
            return values.count == 81 ? values : nil
        }
    }
}
