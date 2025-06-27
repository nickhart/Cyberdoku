//
//  AboutView.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//


// AboutView.swift
import SwiftUI

struct AboutView: View {
    @ObservedObject var appViewModel: AppViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("About")
                .font(.largeTitle)
                .bold()

            Text("This is a placeholder for the About screen.")

            Button("Back") {
                appViewModel.currentScreen = .mainMenu
            }
        }
        .padding()
    }
}
