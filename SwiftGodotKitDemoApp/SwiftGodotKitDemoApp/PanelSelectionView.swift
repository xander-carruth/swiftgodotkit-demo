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
    @SwiftUI.Environment(\.godotApp) private var godotApp: GodotApp?
    @State private var selectedColor: PanelColor?
    
    let squareCallback = { (subwindow: Window) -> () in
        guard let packed = ResourceLoader.load(path: "res://SelectableSquares.tscn") as? PackedScene else {
            return
        }
        
        let gameRoot = packed.instantiate()
        subwindow.addChild(node: gameRoot)
    }
    
    
    var body: some View {
        VStack {
            GodotAppView()
//            GodotWindow(callback: squareCallback)
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
