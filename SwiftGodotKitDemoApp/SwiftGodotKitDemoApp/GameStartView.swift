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
//            GodotWindow(callback: gameCallback)
            Button("Start game") {
                navModel.path.append(Route.godotOverlay)
            }
        }
        .ignoresSafeArea()
    }
}
