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
    var isAnimated: Bool = false
    var expandedDescription: String
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
    expandedDescription: "Neptune, the eighth planet from the Sun, is known for its striking blue color and dynamic atmosphere, which includes the fastest winds in the solar system. This gas giant, discovered in 1846, has a prominent role in understanding planetary formation and atmospheric dynamics due to its complex weather patterns and unique position in the outer solar system."
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
    radius: "2.4397 × 10³",
    mass: "3.3010 × 10²³",
    volume: "6.08272 × 10¹⁰",
    atmosphere: ["atmosphere-mercury-1", "atmosphere-mercury-2", "atmosphere-mercury-3", "atmosphere-mercury-4", "atmosphere-mercury-5", "atmosphere-mercury-6"],
    expandedDescription: "Mercury, the closest planet to the Sun, experiences extreme temperatures due to its lack of a substantial atmosphere and rapid orbital period. Its surface, marked by craters and ridges, provides critical insights into the early solar system's history and planetary formation."
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
    radius: "6.0518 × 10³",
    mass: "4.8673 × 10²⁴",
    volume: "9.28415 × 10¹¹",
    atmosphere: ["atmosphere-venus-1", "atmosphere-venus-2"],
    expandedDescription: "Venus, shrouded in a thick, toxic atmosphere of carbon dioxide and sulfuric acid clouds, is the hottest planet in our solar system. Its extreme surface temperatures and atmospheric pressure offer a glimpse into the greenhouse effect, making it a crucial subject of study for understanding atmospheric sciences."
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
    radius: "6.3710 × 10³",
    mass: "5.9722 × 10²⁴",
    volume: "1.08321 × 10¹²",
    atmosphere: ["atmosphere-earth-1", "atmosphere-earth-2"],
    expandedDescription: "Earth, our home planet, is unique for its abundant liquid water and life-supporting atmosphere. Its diverse ecosystems and geological activity are central to studying planetary habitability and environmental sciences."
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
    radius: "3.3895 × 10³",
    mass: "3.3895 × 10²³",
    volume: "1.63116 × 10¹¹",
    atmosphere: ["atmosphere-mars-1", "atmosphere-mars-2", "atmosphere-mars-3"],
    expandedDescription: "Mars, known as the Red Planet due to its iron oxide-rich surface, features vast canyons, extinct volcanoes, and polar ice caps. Its potential for past or present life and suitability for human exploration make it a focal point of planetary science and exploration missions."
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
    radius: "6.9911 × 10⁴",
    mass: "1.8981 × 10²⁷",
    volume: "1.43128 × 10¹⁵",
    atmosphere: ["atmosphere-jupiter-1", "atmosphere-jupiter-2"],
    expandedDescription: "Jupiter, the largest planet in our solar system, is renowned for its Great Red Spot, a giant storm persisting for centuries. Its complex system of rings, numerous moons, and powerful magnetic field offer valuable insights into gas giant formation and dynamics."
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
    expandedDescription: "Saturn is distinguished by its extensive ring system, composed of ice and rock particles, making it one of the most visually striking planets. Its numerous moons and gaseous composition provide key insights into planetary ring systems and gas giant properties."
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
    expandedDescription: "Uranus is unique for its extreme axial tilt, which causes it to rotate on its side, leading to unusual seasonal variations. Its pale blue-green color results from methane in its atmosphere, and it offers valuable data on ice giant composition and atmospheric phenomena."
)


let innerPlanets = [
    mercuryPlanet, venusPlanet, earthPlanet, marsPlanet
]


let outerPlanets = [
    jupiterPlanet, saturnPlanet, uranusPlanet, neptunePlanet
]

let allPlanets = [
    mercuryPlanet, venusPlanet, earthPlanet, marsPlanet, jupiterPlanet, saturnPlanet, uranusPlanet, neptunePlanet
]


