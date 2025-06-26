//
//  Move.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

enum MoveReason: String, Codable {
    case nakedSingle
    case hiddenSingle
    case nakedPair
    case guess
    case userInput
    case other
}

struct Move: Equatable {
    let index: Int       // 0...80
    let value: Int       // 1...9
    let reason: MoveReason
}
