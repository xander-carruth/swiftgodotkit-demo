//
//  GameStartView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI
import SwiftGodot
import SwiftGodotKit

struct GameStartView: View {
    @SwiftUI.Environment(\.godotApp) private var godotApp: GodotApp?
    
    let gameCallback = { (subwindow: Window) -> () in
        guard let packed = ResourceLoader.load(path: "res://SelectableSquares.tscn") as? PackedScene else {
            return
        }
        
        let gameRoot = packed.instantiate()
        subwindow.addChild(node: gameRoot)
    }
    
    var body: some View {
        VStack {
            GodotWindow(callback: gameCallback)
            Text("hello")
        }
        .ignoresSafeArea()
    }
}
