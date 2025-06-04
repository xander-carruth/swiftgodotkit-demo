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
    @StateObject private var godotApp = GodotApp(packFile: "demo.pck")
    
    init() {
        let appearance = UITabBar.appearance()
        appearance.barTintColor = .white
        appearance.tintColor = .systemBlue
        appearance.unselectedItemTintColor = .gray
        initHookCb = { level in
            guard level == .scene else { return }
            
            register(type: GodotSwiftMessenger.self)
            Engine.registerSingleton(name: "GodotSwiftMessenger", instance: GodotSwiftMessenger.shared)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.godotApp, godotApp)
        }
    }
}
