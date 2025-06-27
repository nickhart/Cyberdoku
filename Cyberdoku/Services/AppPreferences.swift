//
//  AppPreferences.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/27/25.
//

import Foundation

enum UserDefaultsKeys {
    static let defaultDifficulty = "defaultDifficulty"
    static let colorPalette = "colorPalette"
    static let resumeGameAvailable = "resumeGameAvailable"
}

final class AppPreferences: ObservableObject {
    private static let defaults = UserDefaults.standard

    static var defaultDifficulty: PuzzleDifficulty {
        get {
            guard let raw = defaults.string(forKey: UserDefaultsKeys.defaultDifficulty),
                  let value = PuzzleDifficulty(rawValue: raw)
            else { return .easy }
            return value
        }
        set {
            defaults.set(newValue.rawValue, forKey: UserDefaultsKeys.defaultDifficulty)
        }
    }

    static var colorPalette: String? {
        get { defaults.string(forKey: UserDefaultsKeys.colorPalette) }
        set { defaults.set(newValue, forKey: UserDefaultsKeys.colorPalette) }
    }

    static var resumeGameAvailable: Bool {
        get { defaults.bool(forKey: UserDefaultsKeys.resumeGameAvailable) }
        set { defaults.set(newValue, forKey: UserDefaultsKeys.resumeGameAvailable) }
    }
}

