//
//  RootView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI

enum Route: Hashable, Codable {
    case godotOverlay
}

final class NavModel: ObservableObject {
    @Published var path = NavigationPath()
}

struct RootView: View {
    @StateObject private var navModel = NavModel()
    var body: some View {
        NavigationStack(path: $navModel.path) {
            TabView {
                PanelSelectionView()
                    .tabItem { Label("Panel Selection", systemImage: "2.circle") }
                GameStartView()
                    .tabItem { Label("Start", systemImage: "1.circle") }
            }
            .tint(.indigo)
            // push destination
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .godotOverlay:
                    CharacterGameView()
                }
            }
            .environmentObject(navModel)
        }

    }
}

#Preview {
    RootView()
}

