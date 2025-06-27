//
//  SettingsView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var appViewModel: AppViewModel
    @State private var toggleOption = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Settings")
                .font(.largeTitle)
                .bold()

            Toggle("Placeholder Option", isOn: $toggleOption)

            Button("Back") {
                appViewModel.currentScreen = .mainMenu
            }
        }
        .padding()
    }
}
