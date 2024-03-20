//
//  Tips.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 12/30/23.
//

import Foundation
import TipKit

@available(iOS 17, *)
let planetTip = PlanetTip()

@available(iOS 17, *)
let modelTip = ModelTip()

@available(iOS 17, *)
struct PlanetTip: Tip {
    var title: Text {
        Text("Visit a Planet:")
            .foregroundStyle(.launchScreenBackground)
    }
    
    var message: Text? {
        Text("Tap to learn more about the planet's details")
            .foregroundStyle(.white)
    }
    
    var image: Image? {
        Image(systemName: "globe.americas")
        
    }
}

@available(iOS 17, *)
struct SwiftTip: Tip {
    var title: Text {
        Text("Send a Message")
            .foregroundStyle(.launchScreenBackground)
    }
    
    var message: Text? {
        Text("and expect a *Swift* response")
            .foregroundStyle(.white)
    }
    
}

@available(iOS 17, *)
struct ModelTip: Tip {
    var title: Text {
        Text("Explore Planet:")
            .foregroundStyle(.launchScreenBackground)
    }
    
    var message: Text? {
        Text("Tap to experience the 3D model up close.")
            .foregroundStyle(.white)
    }
    
    var image: Image? {
        Image(systemName: "move.3d")
    }
}

