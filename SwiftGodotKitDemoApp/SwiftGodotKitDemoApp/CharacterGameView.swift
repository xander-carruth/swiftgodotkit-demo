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
            w.removeChild(node: child!)
        }
        
        // Subviewport with its own World3D so it exist separately from the main world
        let vp = SubViewport()
        vp.size = w.size
        vp.world3d = World3D()

        // Creat container across whole view
        let vpContainer = SubViewportContainer()
        vpContainer.setAnchorsPreset(.fullRect)
        vpContainer.addChild(node: vp)
        w.addChild(node: vpContainer)
        
        // The viewport should be resized along with the window
        w.sizeChanged.connect { [weak vp, weak w] in
            guard let vp, let w else { return }
            vp.size = w.size
        }

        // Instance the scene and add to the viewport
        if let packed = ResourceLoader.load(path: "res://src/CharacterGameplay/CharacterGameplay.tscn") as? PackedScene {
            vp.addChild(node: packed.instantiate())
        }
    }
    
    var body: some View {
        VStack {
            GodotWindow(callback: gameCallback)
        }
        .ignoresSafeArea()
    }
}
