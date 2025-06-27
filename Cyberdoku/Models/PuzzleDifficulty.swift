//
//  PuzzleDifficulty.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


enum PuzzleDifficulty: String, Codable, CaseIterable, Identifiable {
    case easy
    case medium
    case hard
    case expert
    case bonkers

    var id: String { self.rawValue }

    var description: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        case .expert:
            return "Expert"
        case .bonkers:
            return "Bonkers"
        }
    }
}
