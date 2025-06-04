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
    
    let squareCallback: (Window) -> Void = { w in
        for child in w.getChildren() {
            w.removeChild(node: child!)
        }
        
        // 1. SubViewport + container so it actually shows up
        let vp = SubViewport()
        print(w.size)
        vp.size = w.size                  // or a fixed Vector2i
        vp.world3d = World3D()

        let vpContainer = SubViewportContainer()
        vpContainer.setAnchorsPreset(.fullRect)
        vpContainer.addChild(node: vp)
        
        w.addChild(node: vpContainer)              // keep it in the tree
        
        w.sizeChanged.connect { [weak vp, weak w] in
            guard let vp, let w else { return }
            vp.size = w.size
        }

        // 2. Instance the scene and put it *in the viewport*
        if let packed = ResourceLoader.load(path: "res://src/SelectableSquares/SelectableSquares.tscn") as? PackedScene {
            vp.addChild(node: packed.instantiate())
        }
    }

    
    
    var body: some View {
        VStack {
            GodotAppView()
            GodotWindow(callback: squareCallback)
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
