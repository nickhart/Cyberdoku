//
//  Rule.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

protocol Rule {
    var name: String { get }
    func apply(to board: SudokuBoard) -> [Move]
}

