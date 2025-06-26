//
//  PuzzleLoader.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//
import Foundation

struct Puzzle: Codable {
    let title: String
    let template: [Int]
}

final class PuzzleLoader {
    static func load(named name: String) -> Puzzle? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            print("❌ Puzzle not found")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Puzzle.self, from: data)
        } catch {
            print("❌ Failed to load puzzle: \(error)")
            return nil
        }
    }
}

