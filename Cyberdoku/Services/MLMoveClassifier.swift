//
//  MLMoveClassifier.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import CoreML

class MLMoveClassifier {
    private let model: SudokuClassifier_1

    init() {
        do {
            self.model = try SudokuClassifier_1(configuration: .init())
        } catch {
            fatalError("Failed to load SudokuClassifier_1 model: \(error)")
        }
    }

    func classify(board: [Int]) -> String? {
        guard board.count == 81 else { return nil }

        do {
//            let input = try MLMultiArray(shape: [81], dataType: .int32)
//            for (i, val) in board.enumerated() {
//                input[i] = NSNumber(value: val)
//            }

            let inputWrapper = try SudokuClassifier_1Input(from: board)
            let prediction = try model.prediction(input: inputWrapper)
            return prediction.label
        } catch {
            print("Error during classification: \(error)")
            return nil
        }
    }
}
