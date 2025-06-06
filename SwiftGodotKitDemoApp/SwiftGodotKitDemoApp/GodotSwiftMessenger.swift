//
//  GodotSwiftMessenger.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftGodot

@Godot
class GodotSwiftMessenger: Object {
    public static let shared = GodotSwiftMessenger()
    
    // Signals color of current active panel to start ColorSheetView
    @Signal var panelSelected: SignalWithArguments<String>
    // Signals when to return from CharacterGameView back to GameStartView
    @Signal var gameEnded: SimpleSignal
    // Signals when to change rotating cube color
    @Signal var changeCubeColor: SignalWithArguments<Int>
    // Signals when loading spinner should disappear, otherwise red background flashes
    @Signal var sceneReady: SignalWithArguments<String>
}
