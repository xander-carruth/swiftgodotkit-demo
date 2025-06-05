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
    @Signal var panelSelected: SignalWithArguments<String>
    @Signal var gameEnded: SimpleSignal
    @Signal var changeCubeColor: SignalWithArguments<Int>
}
