//
//  CellView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/27/25.
//

import SwiftUI

struct CellView: View {
//    @EnvironmentObject var preferences: AppPreferences
    @EnvironmentObject var appearance: AppearanceSettings

    let cell: SudokuCell
    let isAgentModified: Bool
    let row: Int
    let col: Int
    let onSelect: () -> Void
    let isShaded: Bool

    var body: some View {
        Button(action: onSelect) {
            let palette = appearance.resolvedPalette
            let backgroundColor: Color = {
                if isAgentModified {
                    return palette.agentModifiedBackground
                } else if cell.value == 0 {
                    return isShaded ? palette.cellBackgroundEmptyShaded : palette.cellBackgroundEmptyUnshaded
                } else if cell.isOriginal {
                    return isShaded ? palette.cellBackgroundOriginalShaded : palette.cellBackgroundOriginalUnshaded
                } else {
                    return palette.cellBackgroundUserEntry
                }
            }()
            ZStack {
                if cell.value > 0 {
                    Text("\(cell.value)")
                        .monospacedDigit()
                        .fontWeight(.semibold)
                        .foregroundColor(palette.color(for: cell.value))
                } else {
                    NoteGridView(cell: cell)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(borderColor(for: cell), lineWidth: borderWidth(for: cell))
            )
            .contentShape(Rectangle())
        }
        .allowsHitTesting(!cell.isOriginal)
        .buttonStyle(PlainButtonStyle())
    }
    
    private func borderColor(for cell: SudokuCell) -> Color {
        // Temporary logic
        if row % 2 == 0 {
            return appearance.resolvedPalette.trainingPrimaryBorder
        } else if row % 3 == 0 {
            return appearance.resolvedPalette.trainingSecondaryBorder
        } else {
            return appearance.resolvedPalette.borderColor
        }
    }

    private func borderWidth(for cell: SudokuCell) -> CGFloat {
        if row % 2 == 0 {
            return 3
        } else if row % 3 == 0 {
            return 1.5
        } else {
            return 1
        }
    }
}
