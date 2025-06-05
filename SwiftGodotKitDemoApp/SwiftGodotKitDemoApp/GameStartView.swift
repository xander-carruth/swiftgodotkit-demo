//
//  GameStartView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI
import SwiftGodot
import SwiftGodotKit

struct GameStartView: View {
    @EnvironmentObject private var navModel: NavModel
    
    var body: some View {
        VStack {
            Button("Start game") {
                navModel.path.append(Route.godotOverlay)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            GodotSwiftMessenger.shared.gameEnded.connect {
                if !navModel.path.isEmpty {
                    navModel.path.removeLast()
                }
            }
        }
    }
}
