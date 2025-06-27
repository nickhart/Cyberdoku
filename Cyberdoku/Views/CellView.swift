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
            let backgroundColor = isAgentModified ? palette.agentModifiedBackground :
            (isShaded ? palette.shadedBoxBackground :
                palette.cellBackground)
            Text(cell.value > 0 ? "\(cell.value)" : "")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(backgroundColor)
                .foregroundColor(palette.color(for: cell.value))
                .border(palette.borderColor)
                .contentShape(Rectangle())
        }
        .disabled(cell.isOriginal)
        .buttonStyle(PlainButtonStyle())
    }
}
