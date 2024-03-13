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
    var name: String
    var imageName: String
    var description: String
    var visual: String
    var color: Color
    var moons: Int
    var rings: Int
    var gravity: Float
    var density: Float
    var radius: String
    var mass: String
    var volume: String
    var images: [String]?
    var atmosphere: [String]
}

let neptunePlanet = Planet(
    name: "Neptune",
    imageName: "smiling-neptune",
    description: "Deep blue, distant, turbulent, gas giant planet.", 
    visual: "Wednesday, September 23, 1846",
    color: .colorNeptune,
    moons: 14,
    rings: 5,
    gravity: 11.15,
    density: 1.638,
    radius: "2.4622 × 10⁴",
    mass: "1.0241 × 10²⁶",
    volume: "6.2526 × 10¹³",
    atmosphere: ["ch4-neptune", "h2-neptune", "he-neptune"]
)

let mercuryPlanet = Planet(
    name: "Mercury",
    imageName: "smiling-mercury",
    description: "Closest planet to the Sun, with extreme temperatures.",
    visual: "Sometime between 1610s and 1630s",
    color: .colorMercury,
    moons: 0,
    rings: 0,
    gravity: 3.7,
    density: 5.427,
    radius: "2.4397 x 10³",
    mass: "3.3010 x 10²³",
    volume: "6.08272 x 10¹⁰",
    atmosphere: ["atmosphere-mercury-1", "atmosphere-mercury-2", "atmosphere-mercury-3", "atmosphere-mercury-4", "atmosphere-mercury-5", "atmosphere-mercury-6"]
)

let venusPlanet = Planet(
    name: "Venus",
    imageName: "smiling-venus",
    description: "Known for its thick, toxic atmosphere and scorching heat.",
    visual: "Sometime between 1610s and 1630s",
    color: .colorVenus,
    moons: 0,
    rings: 0,
    gravity: 8.87,
    density: 5.243,
    radius: "6.0518 x 10³",
    mass: "4.8673 x 10²⁴",
    volume: "9.28415 x 10¹¹",
    atmosphere: ["atmosphere-venus-1", "atmosphere-venus-2"]
)

let earthPlanet = Planet(
    name: "Earth",
    imageName: "smiling-earth",
    description: "Blue planet teeming with life and diverse ecosystems.",
    visual: "After the 16th century",
    color: .miamiBlue,
    moons: 1,
    rings: 0,
    gravity: 9.80665,
    density: 5.513,
    radius: "6.3710 x 10³",
    mass: "5.9722 x 10²⁴",
    volume: "1.08321 x 10¹²",
    atmosphere: ["atmosphere-venus-1", "atmosphere-venus-2"]
)


let innerPlanets = [
//    Planet(imageName: "smiling-mercury", name: "Mercury", description: "Closest planet to the Sun, with extreme temperatures.", color: .innerPlanets),
//    Planet(imageName: "smiling-venus", name: "Venus", description: "Known for its thick, toxic atmosphere and scorching heat.", color: .innerPlanets),
//    Planet(imageName: "smiling-earth", name: "Earth", description: "Blue planet teeming with life and diverse ecosystems.", color: .innerPlanets),
//    Planet(imageName: "smiling-mars", name: "Mars", description: "The red planet, with intriguing geological features.", color: .innerPlanets),
    mercuryPlanet, venusPlanet, earthPlanet
        
]


let outerPlanets = [
//    Planet(imageName: "smiling-jupiter", name: "Jupiter", description: "The largest planet, famous for its massive storm, the Great Red Spot.", color: .outerPlanets),
//    Planet(imageName: "smiling-saturn", name: "Saturn", description: "Known for its mesmerizing rings and numerous moons.", color: .outerPlanets),
//    Planet(imageName: "smiling-uranus", name: "Uranus", description: "An ice giant planet with a unique sideways rotation.", color: .outerPlanets),
//    Planet(imageName: "smiling-neptune", name: "Neptune", description: "Deep blue, distant, turbulent, gas giant planet.", color: .outerPlanets),
    neptunePlanet
]


