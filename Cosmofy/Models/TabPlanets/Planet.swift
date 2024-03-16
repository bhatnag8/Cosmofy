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
    var data: [ChartData]
}

struct ChartData: Identifiable, Equatable {
    let type: String
    let count: Float
    let color: Color
    let original: Color
    var id: String { return type }
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
    atmosphere: ["ch4-neptune", "h2-neptune", "he-neptune"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .colorNeptune, original: .colorNeptune),
    ]
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
    atmosphere: ["atmosphere-mercury-1", "atmosphere-mercury-2", "atmosphere-mercury-3", "atmosphere-mercury-4", "atmosphere-mercury-5", "atmosphere-mercury-6"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .colorMercury, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
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
    atmosphere: ["atmosphere-venus-1", "atmosphere-venus-2"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .colorVenus, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
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
    atmosphere: ["atmosphere-earth-1", "atmosphere-earth-2"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .miamiBlue, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
)


let innerPlanets = [
//    Planet(imageName: "smiling-mars", name: "Mars", description: "The red planet, with intriguing geological features.", color: .innerPlanets),
    mercuryPlanet, venusPlanet, earthPlanet
        
]


let outerPlanets = [
//    Planet(imageName: "smiling-jupiter", name: "Jupiter", description: "The largest planet, famous for its massive storm, the Great Red Spot.", color: .outerPlanets),
//    Planet(imageName: "smiling-saturn", name: "Saturn", description: "Known for its mesmerizing rings and numerous moons.", color: .outerPlanets),
//    Planet(imageName: "smiling-uranus", name: "Uranus", description: "An ice giant planet with a unique sideways rotation.", color: .outerPlanets),
    neptunePlanet
]


