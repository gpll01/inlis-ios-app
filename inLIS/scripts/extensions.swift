//
//  extensions.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// Extensions.swift
// Utility: Color(hex:) e PreferenceKey per lo scroll
import SwiftUI

// Crea un colore da un hex string tipo "F8E5D5"
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (255,255,255)
        }
        self.init(.sRGB, red: Double(r)/255.0, green: Double(g)/255.0, blue: Double(b)/255.0, opacity: 1)
    }
}

// PreferenceKey per tracciare lo scroll (usato per cambiare il titolo quando si scrolla)
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
