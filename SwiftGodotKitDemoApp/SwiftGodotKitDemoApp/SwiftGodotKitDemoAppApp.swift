//
//  SwiftGodotKitDemoAppApp.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI
import SwiftGodotKit
import SwiftGodot

@main
struct SwiftGodotKitDemoAppApp: App {
    // GodotApp can only use one .pck file, include all scenes in the .pck specified here
    @StateObject private var godotApp = GodotApp(packFile: "demo.pck")
    
    init() {
        let appearance = UITabBar.appearance()
        appearance.barTintColor = .white
        appearance.tintColor = .systemBlue
        appearance.unselectedItemTintColor = .gray
        initHookCb = { level in
            guard level == .scene else { return }
            
            // Register signal manager singleton with the godot engine
            register(type: GodotSwiftMessenger.self)
            Engine.registerSingleton(name: "GodotSwiftMessenger", instance: GodotSwiftMessenger.shared)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            // Place godot app into environment
            RootView()
                .environment(\.godotApp, godotApp)
        }
    }
}
