//
//  NoteGridView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/29/25.
//


import SwiftUI

struct NoteGridView: View {
    let cell: SudokuCell

    var body: some View {
        debugCheck()

        return VStack(spacing: 1) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(1...3, id: \.self) { col in
                        let n = row * 3 + col
                        ZStack {
                            if cell.positiveNotes.contains(n) {
                                Text("\(n)")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            } else if cell.negativeNotes.contains(n) {
                                Text("\(n)")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .overlay(
                                        GeometryReader { geometry in
                                            Path { path in
                                                let size = geometry.size
                                                path.move(to: .zero)
                                                path.addLine(to: CGPoint(x: size.width, y: size.height))
                                                path.move(to: CGPoint(x: 0, y: size.height))
                                                path.addLine(to: CGPoint(x: size.width, y: 0))
                                            }
                                            .stroke(Color.red, lineWidth: 1)
                                        }
                                    )
                            } else {
                                Color.clear
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }

    private func debugCheck() {
#if DEBUG
        if cell.positiveNotes.rawValue & cell.negativeNotes.rawValue != 0 {
            print("⚠️ Note conflict in cell: both positive and negative notes set for some values")
        }
#endif
    }
}
