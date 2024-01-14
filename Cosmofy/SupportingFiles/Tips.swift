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
            .foregroundStyle(.SOUR)
    }
    
    var message: Text? {
        Text("Tap to learn more about the planet's details")
            .foregroundStyle(.white)
    }
    
    var image: Image? {
        Image(systemName: "globe.americas")

    }
}

struct SwiftTip: Tip {
    var title: Text {
        Text("Send a Message")
            .foregroundStyle(.SOUR)
    }
    
    var message: Text? {
        Text("and expect a *Swift* response")
            .foregroundStyle(.white)
    }
//    
//    var image: Image? {
//        Image("swift")
//    }
}

struct ModelTip: Tip {
    var title: Text {
        Text("Explore Planet:")
            .foregroundStyle(.SOUR)
    }
    
    var message: Text? {
        Text("Tap to experience the 3D model up close.")
            .foregroundStyle(.white)
    }
    
    var image: Image? {
        Image(systemName: "move.3d")
    }
}
