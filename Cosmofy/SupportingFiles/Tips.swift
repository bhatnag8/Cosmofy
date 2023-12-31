//
//  Tips.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 12/30/23.
//

import Foundation
import TipKit

let planetTip = PlanetTip()
let modelTip = ModelTip()


struct PlanetTip: Tip {
    var title: Text {
        Text("Visit a Planet:")
    }
    
    var message: Text? {
        Text("Tap to learn more about the planet's details")
    }
    
    var image: Image? {
        Image(systemName: "globe.americas")
    }
}

struct ModelTip: Tip {
    var title: Text {
        Text("Explore Planet:")
    }
    
    var message: Text? {
        Text("Tap to experience the 3D model up close.")
    }
    
    var image: Image? {
        Image(systemName: "move.3d")
    }
}
