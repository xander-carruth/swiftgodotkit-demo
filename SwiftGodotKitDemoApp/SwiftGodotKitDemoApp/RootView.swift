//
//  RootView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            PanelSelectionView()
                .tabItem {
                    Label("Panel Selection", systemImage: "2.circle")
                }
            
            GameStartView()
                .tabItem {
                    Label("Start", systemImage: "1.circle")
                }
            
            
        }
        .tint(.indigo)
    }
}

#Preview {
    RootView()
}

