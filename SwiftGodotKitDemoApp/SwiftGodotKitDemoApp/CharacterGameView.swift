//
//  CharacterGameView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/5/25.
//

import SwiftUI
import SwiftGodot
import SwiftGodotKit

struct CharacterGameView: View {
    @SwiftUI.Environment(\.godotApp) private var godotApp: GodotApp?
    
    let gameCallback: (Window) -> Void = { w in
        for child in w.getChildren() {
            w.removeChild(node: (child as! Node))
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
        if let packed = ResourceLoader.load(path: "res://src/CharacterGameplay/CharacterGameplay.tscn") as? PackedScene {
            vp.addChild(node: packed.instantiate())
        }
    }
    
    var body: some View {
        VStack {
            GodotWindow(callback: gameCallback)
//            Text("Hello")
        }
        .ignoresSafeArea()
    }
}
