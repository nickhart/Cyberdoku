//
//  NoteBitset.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/29/25.
//

import Foundation

struct NoteBitset: OptionSet, Codable {
    let rawValue: UInt16

    init(rawValue: UInt16) {
        self.rawValue = rawValue
    }

    static func forValue(_ n: Int) -> NoteBitset {
        NoteBitset(rawValue: 1 << (n - 1))
    }

    func contains(_ n: Int) -> Bool {
        contains(NoteBitset.forValue(n))
    }

    mutating func insert(_ n: Int) {
        self.insert(NoteBitset.forValue(n))
    }

    mutating func remove(_ n: Int) {
        self.remove(NoteBitset.forValue(n))
    }

    static var allValues: NoteBitset {
        NoteBitset(rawValue: 0b1_1111_1111) // all digits 1-9
    }

    var values: [Int] {
        (1...9).filter { contains($0) }
    }
}


