//
//  ColorSheetView.swift
//  SwiftGodotKitDemoApp
//
//  Created by Xander Carruth on 6/2/25.
//

import SwiftUI

struct ColorSheetView: View {
    let colorName: String
    var body: some View {
        convertColor(name: colorName)
        Text("Hello, this view is \(colorName)")
    }
    
    private func convertColor(name: String) -> Color {
        switch name.lowercased() {
        case "green":   return .green
        case "pink":    return .pink
        case "yellow": return .yellow
        case "blue": return .teal
        default: return .white
        }
    }
}

#Preview {
    ColorSheetView(colorName: "Pink")
}
