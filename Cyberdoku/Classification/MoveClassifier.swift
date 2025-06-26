//
//  Classifier.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

// MoveClassification.swift
enum MoveClassification: String {
    case nakedSingle
    case hiddenSingle
    case nakedPair
    // Add more as needed
}

// MoveClassifier.swift
protocol MoveClassifier {
    func classify(board: SudokuBoard) -> [Move]
}

