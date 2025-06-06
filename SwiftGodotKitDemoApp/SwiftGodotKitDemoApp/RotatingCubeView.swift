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
    @State private var colorChangeCount: Int = 0
    
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
            GodotSceneWindowView(scenePath: "res://src/RotatingCube/RotatingCube.tscn")
            GodotSceneWindowView(scenePath: "res://src/RotatingCube/RotatingCube.tscn")
        }
    }
}
