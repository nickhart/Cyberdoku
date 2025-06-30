//
//  SudokuCell.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

struct SudokuCell: Identifiable, Codable {
    let id = UUID()
    var value: Int      // 0 if empty
    var row: Int
    var col: Int
    var isOriginal: Bool
    var positiveNotes: NoteBitset = []
    var negativeNotes: NoteBitset = []

    func isPossible(_ n: Int) -> Bool {
        positiveNotes.contains(n)
    }

    func isExcluded(_ n: Int) -> Bool {
        negativeNotes.contains(n)
    }

    enum CodingKeys: String, CodingKey {
        case value, row, col, isOriginal, positiveNotes, negativeNotes
    }

    mutating func togglePositiveNote(_ n: Int) {
        if positiveNotes.contains(n) {
            positiveNotes.remove(n)
        } else {
            positiveNotes.insert(n)
            negativeNotes.remove(n)
        }
    }

    mutating func toggleNegativeNote(_ n: Int) {
        if negativeNotes.contains(n) {
            negativeNotes.remove(n)
        } else {
            negativeNotes.insert(n)
            positiveNotes.remove(n)
        }
    }
}

