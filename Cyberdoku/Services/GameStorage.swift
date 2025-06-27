//
//  GameStorage.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


import Foundation

struct GameStorage {
    static let savePath = URL.documentsDirectory.appendingPathComponent("saved_game.json")

    static func save(_ state: GameState) {
        do {
            let data = try JSONEncoder().encode(state)
            try data.write(to: savePath)
        } catch {
            print("Error saving game: \(error)")
        }
    }

    static func load() -> GameState? {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode(GameState.self, from: data)
        } catch {
            print("No saved game found or failed to decode: \(error)")
            return nil
        }
    }

    static func clear() {
        try? FileManager.default.removeItem(at: savePath)
    }
}

