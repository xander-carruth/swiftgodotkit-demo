//
//  CharacterGameView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/5/25.
//

import SwiftUI

struct CharacterGameView: View {
    
    var body: some View {
        GodotSceneWindowView(sceneName: "res://src/CharacterGameplay/CharacterGameplay.tscn")
    }
}
