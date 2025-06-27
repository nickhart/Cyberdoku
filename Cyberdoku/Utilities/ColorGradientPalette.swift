//
//  ColorGradientPalette.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/27/25.
//


import SwiftUI

extension Color {
    func interpolate(to: Color, fraction: CGFloat) -> Color {
        let fromComponents = UIColor(self).cgColor.components ?? [0, 0, 0, 1]
        let toComponents = UIColor(to).cgColor.components ?? [0, 0, 0, 1]

        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * fraction
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * fraction
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * fraction
        let a = fromComponents[3] + (toComponents[3] - fromComponents[3]) * fraction

        return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
}

extension Color {
    static let deepBlue = Color(red: 0.0, green: 0.2, blue: 0.5)
    static let peach = Color(red: 1.0, green: 0.8, blue: 0.7)
    static let lavender = Color(red: 0.9, green: 0.8, blue: 1.0)
    static let skyBlue = Color(red: 0.53, green: 0.81, blue: 0.92)
}

struct ColorGradientPalette {
    static func generateColors(from anchors: [Color], count: Int) -> [Color] {
        precondition(anchors.count >= 2)
        
        let segments = anchors.count - 1
        let totalSteps = count - 1
        var result: [Color] = []

        for i in 0..<count {
            let t = CGFloat(i) / CGFloat(totalSteps)
            let segmentFloat = t * CGFloat(segments)
            let segment = Int(segmentFloat)
            let localT = segmentFloat - CGFloat(segment)

            let colorA = anchors[segment]
            let colorB = anchors[min(segment + 1, anchors.count - 1)]
            result.append(colorA.interpolate(to: colorB, fraction: localT))
        }

        return result
    }

    static let sunset: [Color] = generateColors(from: [.purple, .pink, .orange, .yellow], count: 9)
    static let ocean: [Color] = generateColors(from: [.deepBlue, .teal, .green, .cyan], count: 9)
    static let rainbow: [Color] = generateColors(from: [.red, .yellow, .green, .blue], count: 9)
    static let pastels: [Color] = generateColors(from: [.mint, .peach, .lavender, .cyan], count: 9)
}
