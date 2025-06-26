//
//  HiddenSingleRule.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Foundation

struct HiddenSingleRule: Rule {
    let name = "Hidden Single"

    func apply(to board: SudokuBoard) -> [Move] {
        let classifier = HiddenSingleClassifier()
        return classifier.classify(board: board)
    }
}

