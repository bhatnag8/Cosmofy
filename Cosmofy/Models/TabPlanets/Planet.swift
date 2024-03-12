//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/12/24.
//

import Foundation
import SwiftUI

struct Planet: Identifiable {
    var id = UUID()
    var imageName: String
    var name: String
    var description: String
    var color: Color
}


let innerPlanets = [
    Planet(imageName: "smiling-mercury", name: "Mercury", description: "Closest planet to the Sun, with extreme temperatures.", color: .innerPlanets),
    Planet(imageName: "smiling-venus", name: "Venus", description: "Known for its thick, toxic atmosphere and scorching heat.", color: .innerPlanets),
    Planet(imageName: "smiling-earth", name: "Earth", description: "Blue planet teeming with life and diverse ecosystems.", color: .innerPlanets),
    Planet(imageName: "smiling-mars", name: "Mars", description: "The red planet, with intriguing geological features.", color: .innerPlanets),
        
]


let outerPlanets = [
    Planet(imageName: "smiling-jupiter", name: "Jupiter", description: "The largest planet, famous for its massive storm, the Great Red Spot.", color: .outerPlanets),
    Planet(imageName: "smiling-saturn", name: "Saturn", description: "Known for its mesmerizing rings and numerous moons.", color: .outerPlanets),
    Planet(imageName: "smiling-uranus", name: "Uranus", description: "An ice giant planet with a unique sideways rotation.", color: .outerPlanets),
    Planet(imageName: "smiling-neptune", name: "Neptune", description: "Deep blue, distant, turbulent, gas giant planet.", color: .outerPlanets),
]


#Preview {
    Planets()
}
