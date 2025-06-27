//
//  LoadGameView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import SwiftUI

struct LoadGameView: View {
    @ObservedObject var appViewModel: AppViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("Load Game")
                .font(.largeTitle)
                .bold()

            Text("This is a placeholder for the Load Game screen.")

            Button("Back") {
                appViewModel.currentScreen = .mainMenu
            }
        }
        .padding()
    }
}
