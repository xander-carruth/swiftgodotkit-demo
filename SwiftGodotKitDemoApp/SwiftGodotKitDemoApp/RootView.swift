//
//  RootView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI
import SwiftGodotKit

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
                // Select a panel and pop up a view with same color
                PanelSelectionView()
                    .tabItem { Label("Panel", systemImage: "1.circle") }
                // Start a game that allows you to move around a scene
                GameStartView()
                    .tabItem { Label("Game", systemImage: "2.circle") }
                // View a rotating cube and change its color
                RotatingCubeView()
                    .tabItem { Label("Cube", systemImage: "3.circle") }
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
            .background(
                // App view must be instanced first so place into background so it doesn't consume
                // layout space
                GodotAppView()
                    .opacity(0)
                    .frame(width: 0, height: 0)
                    .background(Color.red)
            )
        }

    }
}

#Preview {
    RootView()
}

