//
//  SudokuCell.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

struct SudokuCell: Identifiable {
    let id = UUID()
    var value: Int      // 0 if empty
    var row: Int 
    var col: Int
    var isOriginal: Bool
    var notes: Set<Int> = [] // optimization: use BitSet?
}

