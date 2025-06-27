//
//  PuzzleLoader.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//
import Foundation

struct Puzzle: Codable {
    static let empty = Puzzle(title: "Empty", template: [])
    let title: String
    let template: [Int]
}

final class PuzzleLoader {
    static func load(difficulty: PuzzleDifficulty, index: Int? = nil) -> Puzzle? {
        let name = difficulty.rawValue

        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            print("❌ Puzzle not found")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let puzzles = try JSONDecoder().decode([Puzzle].self, from: data)
            let index = index ?? Int.random(in: 0..<puzzles.count)
            if index >= puzzles.count {
                print("❌ Invalid puzzle index: \(index)")
                return nil
            }
            return puzzles[index]
        } catch {
            print("❌ Failed to load puzzle: \(error)")
            return nil
        }
    }
}
