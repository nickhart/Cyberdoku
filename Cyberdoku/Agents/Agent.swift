//
//  Agent.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

protocol Agent {
    var name: String { get }
    func nextMoves(for board: SudokuBoard) -> [Move]
}

