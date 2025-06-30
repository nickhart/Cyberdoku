//
//  NoteBitsetTest.swift
//  CyberdokuTests
//
//  Created by Nick Hart on 6/29/25.
//

import Testing

@testable import Cyberdoku

struct NoteBitsetTest {
    @Test
    func testInsertAndContains() {
        var bitset = NoteBitset()
        #expect(!bitset.contains(5))

        bitset.insert(5)
        #expect(bitset.contains(5))

        bitset.insert(1)
        #expect(bitset.contains(1))
        #expect(!bitset.contains(2))
    }

    @Test
    func testRemove() {
        var bitset = NoteBitset()
        bitset.insert(3)
        #expect(bitset.contains(3))

        bitset.remove(3)
        #expect(!bitset.contains(3))
    }

    @Test
    func testEmptyState() {
        var bitset = NoteBitset()
        #expect(bitset.isEmpty)

        bitset.insert(7)
        #expect(!bitset.isEmpty)

        bitset.remove(7)
        #expect(bitset.isEmpty)
    }

    @Test
    func testRawValueMapping() {
        var bitset = NoteBitset()
        bitset.insert(2)
        bitset.insert(4)
        let raw = bitset.rawValue

        let restored = NoteBitset(rawValue: raw)
        #expect(restored.contains(2))
        #expect(restored.contains(4))
        #expect(!restored.contains(3))
    }
}
