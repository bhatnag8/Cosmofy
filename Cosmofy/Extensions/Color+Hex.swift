//
//  Color+Hex.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}
