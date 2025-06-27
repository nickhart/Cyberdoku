//
//  SudokuBoard+Serialization.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

extension SudokuBoard {
    /// Returns a flat array of 81 cell values (0 = empty)
    var serializedValues: [Int] {
        cells.map { $0.value }
    }

    /// Returns a 2D array of possible values for each cell
    var serializedPossibilities: [[Int]] {
        cells.map { cell in
            guard cell.value == 0 else { return [] }
            return possibleValues(for: cell)
        }
    }

    /// Combined format for AI agents or debug
    var aiPayload: [String: Any] {
        [
            "values": serializedValues,
            "possibilities": serializedPossibilities
        ]
    }

    func aiPayloadJSON(prettyPrinted: Bool = false) throws -> Data {
        let options: JSONSerialization.WritingOptions = prettyPrinted ? [.prettyPrinted] : []
        return try JSONSerialization.data(withJSONObject: aiPayload, options: options)
    }
}

