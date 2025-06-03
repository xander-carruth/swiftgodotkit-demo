//
//  ContentView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI
import SwiftGodot
import SwiftGodotKit

struct PanelColor: Identifiable {
    let id = UUID()
    let name: String
}

struct PanelSelectionView: View {
    @State private var godotApp: GodotApp = GodotApp(packFile: "demo.pck")
    @State private var selectedColor: PanelColor?
    var body: some View {
        VStack {
            GodotAppView()
                .environment(\.godotApp, godotApp)
        }
        .sheet(item: $selectedColor) { panelColor in
            ColorSheetView(colorName: panelColor.name)
        }
        .onAppear {
            GodotSwiftMessenger.shared.panelSelected.connect { viewColor in
                selectedColor = PanelColor(name: viewColor)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PanelSelectionView()
}
