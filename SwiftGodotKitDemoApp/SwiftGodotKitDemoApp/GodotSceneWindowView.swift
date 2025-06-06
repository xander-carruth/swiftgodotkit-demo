//
//  GodotSceneWindow.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/6/25.
//

import SwiftUI
import SwiftGodot
import SwiftGodotKit

struct GodotSceneWindowView: View {
    let sceneName: String
    
    @SwiftUI.Environment(\.godotApp) private var godotApp: GodotApp?
    @State private var loading = true
    private var token: String
    
    init(sceneName: String) {
        self.sceneName = sceneName
        self.token = UUID().uuidString
    }
    
    var body: some View {
        ZStack {
            GodotWindow { [token] window in
                buildViewPort(for: window, token: token)
            }
            .ignoresSafeArea()
            
            if loading {
                Color.gray
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .onAppear {
            GodotSwiftMessenger.shared.sceneReady.connect { readyToken in
                if readyToken == token {
                    loading = false
                }
            }
        }
    }
    
    private func buildViewPort(for w: Window, token: String) {
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
        if let packed = ResourceLoader.load(path: sceneName) as? PackedScene,
           let root = packed.instantiate() {
            root.set(property: "ready_token", value: Variant(token))
            vp.addChild(node: root)
        }
    }
}
