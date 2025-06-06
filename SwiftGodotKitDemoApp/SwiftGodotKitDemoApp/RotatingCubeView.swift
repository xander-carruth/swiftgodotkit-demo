//
//  RotatingSquareView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/5/25.
//

import SwiftUI
import SwiftGodot
import SwiftGodotKit

struct RotatingCubeView: View {
    @SwiftUI.Environment(\.godotApp) private var godotApp: GodotApp?
    
    @State private var colorChangeCount: Int = 0
    
    let rotatingCubeCallback: (Window) -> Void = { w in
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
        if let packed = ResourceLoader.load(path: "res://src/RotatingCube/RotatingCube.tscn") as? PackedScene {
            vp.addChild(node: packed.instantiate())
        }
    }
    
    var body: some View {
        VStack {
            Button("Change Cube Color") {
                colorChangeCount += 1
                // Godot project will log message with the count, signaling that the value was received
                GodotSwiftMessenger.shared.changeCubeColor.emit(colorChangeCount)
            }
            .padding(5)
            .background(Color.gray)
            .padding(5)
            GodotWindow(callback: rotatingCubeCallback)
            GodotWindow(callback: rotatingCubeCallback)
        }
    }
}
