struct CellView: View {
    let cell: SudokuCell
    let isAgentModified: Bool
    let row: Int
    let col: Int
    let onSelect: () -> Void
    let isShaded: Bool
    let preferences: AppPreferences

    var body: some View {
        Button(action: onSelect) {
            Text(cell.value > 0 ? "\(cell.value)" : "")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(
                    isAgentModified ? ColorPalette.current.agentModifiedBackground :
                    (isShaded ? ColorPalette.current.shadedBoxBackground :
                     preferences.selectedColorPalette.cellBackground)
                )
                .foregroundColor(preferences.selectedColorPalette.color(for: cell.value))
                .border(preferences.selectedColorPalette.borderColor)
                .contentShape(Rectangle())
        }
        .disabled(cell.isOriginal)
        .buttonStyle(PlainButtonStyle())
    }
}