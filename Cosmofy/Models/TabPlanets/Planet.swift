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
    var imageNameClosed: String
    var description: String
    var visual: String
    var color: Color
    var moons: Int
    var rings: Int
    var gravity: Float
    var escapeVelocity: String
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
    imageNameClosed: "smiling-neptune",
    description: "A deep blue, distant, and turbulent gas giant.",
    visual: "Wednesday, September 23, 1846",
    color: .colorNeptune,
    moons: 14,
    rings: 5,
    gravity: 11.15,
    escapeVelocity: "84,816",
    radius: "2.4622 × 10⁴",
    mass: "1.0241 × 10²⁶",
    volume: "6.2526 × 10¹³",
    atmosphere: ["atmosphere-neptune-1", "atmosphere-neptune-2", "atmosphere-neptune-3"],
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
    imageNameClosed: "smiling-neptune",
    description: "The closest planet to the Sun, with extreme temperatures.",
    visual: "Sometime between 1610s and 1630s",
    color: .colorMercury,
    moons: 0,
    rings: 0,
    gravity: 3.7,
    escapeVelocity: "15,300",
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
    imageNameClosed: "smiling-neptune",
    description: "Known for its thick, toxic atmosphere and scorching heat.",
    visual: "Sometime between 1610s and 1630s",
    color: .colorVenus,
    moons: 0,
    rings: 0,
    gravity: 8.87,
    escapeVelocity: "37,296",
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
    imageNameClosed: "smiling-neptune",
    description: "The blue planet, teeming with life and diverse ecosystems.",
    visual: "After the 16th century",
    color: .miamiBlue,
    moons: 1,
    rings: 0,
    gravity: 9.80665,
    escapeVelocity: "40,284",
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

let marsPlanet = Planet(
    name: "Mars",
    imageName: "smiling-mars",
    imageNameClosed: "smiling-neptune",
    description: "The red planet, with intriguing geological features.",
    visual: "After the 16th century",
    color: .colorMars,
    moons: 2,
    rings: 0,
    gravity: 3.71,
    escapeVelocity: "18,108",
    radius: "3.3895 x 10³",
    mass: "3.3895 x 10²³",
    volume: "1.63116 x 10¹¹",
    atmosphere: ["atmosphere-mars-1", "atmosphere-mars-2", "atmosphere-mars-3"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .colorMars, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
)

let jupiterPlanet = Planet(
    name: "Jupiter",
    imageName: "smiling-jupiter",
    imageNameClosed: "smiling-neptune",
    description: "The largest planet, famous for the massive Great Red Spot storm.",
    visual: "After the 16th century",
    color: .colorJupiter,
    moons: 95,
    rings: 4,
    gravity: 24.79,
    escapeVelocity: "216,720",
    radius: "6.9911 x 10⁴",
    mass: "1.8981 x 10²⁷",
    volume: "1.43128 x 10¹⁵",
    atmosphere: ["atmosphere-jupiter-1", "atmosphere-jupiter-2"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .colorJupiter, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
)

let saturnPlanet = Planet(
    name: "Saturn",
    imageName: "smiling-saturn",
    imageNameClosed: "smiling-neptune",
    description: "Renowned for its stunning rings and gas giant composition.",
    visual: "Sometime in the 1600s",
    color: .colorSaturn,
    moons: 84,
    rings: 7,
    gravity: 10.44,
    escapeVelocity: "129,924",
    radius: "5.8232 × 10⁴",
    mass: "5.6834 × 10²⁶",
    volume: "8.2713 × 10¹⁴",
    atmosphere: ["atmosphere-saturn-1", "atmosphere-saturn-2"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .colorSaturn, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .primary, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
)


let uranusPlanet = Planet(
    name: "Uranus",
    imageName: "smiling-uranus",
    imageNameClosed: "smiling-neptune",
    description: "Distinctive for its tilted axis and pale blue-green color.",
    visual: "March 13, 1781",
    color: .colorUranus,
    moons: 27,
    rings: 13,
    gravity: 8.87,
    escapeVelocity: "76,968",
    radius: "2.5362 × 10⁴",
    mass: "8.6810 × 10²⁵",
    volume: "6.833 × 10¹³",
    atmosphere: ["atmosphere-uranus-1", "atmosphere-uranus-2", "atmosphere-uranus-3"],
    data: [
        ChartData(type: "Mercury", count: 5.427, color: .primary, original: .colorMercury),
        ChartData(type: "Venus", count: 5.243, color: .primary, original: .colorVenus),
        ChartData(type: "Earth", count: 5.513, color: .primary, original: .miamiBlue),
        ChartData(type: "Mars", count: 3.934, color: .primary, original: .colorMars),
        ChartData(type: "Jupiter", count: 1.326, color: .primary, original: .colorJupiter),
        ChartData(type: "Saturn", count: 0.687, color: .primary, original: .colorSaturn),
        ChartData(type: "Uranus", count: 1.270, color: .colorUranus, original: .colorUranus),
        ChartData(type: "Neptune", count: 1.638, color: .primary, original: .colorNeptune),
    ]
)




let innerPlanets = [
    mercuryPlanet, venusPlanet, earthPlanet, marsPlanet
]


let outerPlanets = [
    jupiterPlanet, saturnPlanet, uranusPlanet, neptunePlanet
]


