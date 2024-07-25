//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/12/24.
//

import Foundation
import SwiftUI

struct Planet: Identifiable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var order: String
    var imageName: String
    var imageNameClosed: String
    var description: String
    var visual: String
    var color: Color
    var moons: Int
    var rings: Int
    var gravity: Int
    var escapeVelocity: String
    var radius: String
    var mass: String
    var volume: String
    var images: [String]?
    var atmosphere: [Atmosphere]
    var isAnimated: Bool = false
    var expandedDescription: String
    var averageTemperature: Int
    var density: Float?
    var orbitalInclination: Float
    static func == (lhs: Planet, rhs: Planet) -> Bool {
            return lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.order == rhs.order &&
                lhs.imageName == rhs.imageName &&
                lhs.imageNameClosed == rhs.imageNameClosed &&
                lhs.description == rhs.description &&
                lhs.visual == rhs.visual &&
                lhs.color == rhs.color &&
                lhs.moons == rhs.moons &&
                lhs.rings == rhs.rings &&
                lhs.gravity == rhs.gravity &&
                lhs.escapeVelocity == rhs.escapeVelocity &&
                lhs.radius == rhs.radius &&
                lhs.mass == rhs.mass &&
                lhs.volume == rhs.volume &&
                lhs.images == rhs.images &&
                lhs.atmosphere == rhs.atmosphere &&
                lhs.isAnimated == rhs.isAnimated &&
                lhs.expandedDescription == rhs.expandedDescription &&
                lhs.averageTemperature == rhs.averageTemperature &&
                lhs.density == rhs.density &&
                lhs.orbitalInclination == rhs.orbitalInclination
        }
}

struct Atmosphere: Identifiable, Hashable {
    var id = UUID()
    var molar: String
    var formula: String
}

let neptuneAtmosphere = [
    Atmosphere(molar: "20", formula: "H₂"),
    Atmosphere(molar: "28", formula: "N₂"),
    Atmosphere(molar: "16", formula: "O₂")
]


let neptunePlanet = Planet(
    name: NSLocalizedString("Neptune", comment: ""),
    order: "8th",
    imageName: "smiling-neptune",
    imageNameClosed: "smiling-neptune",
    description: NSLocalizedString("A deep blue and distant gas giant with turbulent weather.", comment: ""),
    visual: NSLocalizedString("September 23, 1846", comment: ""),
    color: .colorNeptune,
    moons: 14,
    rings: 5,
    gravity: 11,
    escapeVelocity: "84,816",
    radius: "2.4622 × 10⁴",
    mass: "1.0241 × 10²⁶",
    volume: "6.2526 × 10¹³",
    atmosphere: neptuneAtmosphere,
    expandedDescription: NSLocalizedString("Neptune, the eighth planet from the Sun, is known for its striking blue color and dynamic atmosphere, which includes the fastest winds in the solar system. This gas giant, discovered in 1846, has a prominent role in understanding planetary formation and atmospheric dynamics due to its complex weather patterns and unique position in the outer solar system.", comment: ""),
    averageTemperature: -201,
    density: 1.638,
    orbitalInclination: 1.77
)

let mercuryAtmosphere = [
    Atmosphere(molar: "4", formula: "He"),
    Atmosphere(molar: "40", formula: "Ar"),
    Atmosphere(molar: "1", formula: "H")
]

let mercuryPlanet = Planet(
    name: NSLocalizedString("Mercury", comment: ""),
    order: "1st",
    imageName: "smiling-mercury",
    imageNameClosed: "smiling-mercury",
    description: NSLocalizedString("The closest planet to the Sun, facing extreme temperatures.", comment: ""),
    visual: NSLocalizedString("Sometime between 1610s and 1630s", comment: ""),
    color: .colorMercury,
    moons: 0,
    rings: 0,
    gravity: 4,
    escapeVelocity: "15,300",
    radius: "2.4397 × 10³",
    mass: "3.3010 × 10²³",
    volume: "6.08272 × 10¹⁰",
    atmosphere: mercuryAtmosphere,
    expandedDescription: NSLocalizedString("Mercury, the closest planet to the Sun, experiences extreme temperatures due to its lack of a substantial atmosphere and rapid orbital period. Its surface, marked by craters and ridges, provides critical insights into the early solar system's history and planetary formation.", comment: ""),
    averageTemperature: 167,
    density: 5.427,
    orbitalInclination: 7.00
)

let venusAtmosphere = [
    Atmosphere(molar: "44", formula: "CO₂"),
    Atmosphere(molar: "28", formula: "N₂")
]

let venusPlanet = Planet(
    name: NSLocalizedString("Venus", comment: ""),
    order: "2nd",
    imageName: "smiling-venus",
    imageNameClosed: "smiling-venus",
    description: NSLocalizedString("A planet known for its thick, toxic atmosphere and scorching heat.", comment: ""),
    visual: NSLocalizedString("Sometime between 1610s and 1630s", comment: ""),
    color: .colorVenus,
    moons: 0,
    rings: 0,
    gravity: 9,
    escapeVelocity: "37,296",
    radius: "6.0518 × 10³",
    mass: "4.8673 × 10²⁴",
    volume: "9.28415 × 10¹¹",
    atmosphere: venusAtmosphere,
    expandedDescription: NSLocalizedString("Venus, shrouded in a thick, toxic atmosphere of carbon dioxide and sulfuric acid clouds, is the hottest planet in our solar system. Its extreme surface temperatures and atmospheric pressure offer a glimpse into the greenhouse effect, making it a crucial subject of study for understanding atmospheric sciences.", comment: ""),
    averageTemperature: 464,
    density: 5.243,
    orbitalInclination: 3.39
)

let earthAtmosphere = [
    Atmosphere(molar: "29", formula: "N₂"),
    Atmosphere(molar: "32", formula: "O₂")
]

let earthPlanet = Planet(
    name: NSLocalizedString("Earth", comment: ""),
    order: "3rd",
    imageName: "smiling-earth",
    imageNameClosed: "smiling-earth",
    description: NSLocalizedString("The blue planet, rich with life and diverse ecosystems.", comment: ""),
    visual: NSLocalizedString("Earth was always perceived as a planet", comment: ""),
    color: .green,
    moons: 1,
    rings: 0,
    gravity: 10,
    escapeVelocity: "40,284",
    radius: "6.3710 × 10³",
    mass: "5.9722 × 10²⁴",
    volume: "1.08321 × 10¹²",
    atmosphere: earthAtmosphere,
    expandedDescription: NSLocalizedString("Earth, our home planet, is unique for its abundant liquid water and life-supporting atmosphere. Its diverse ecosystems and geological activity are central to studying planetary habitability and environmental sciences.", comment: ""),
    averageTemperature: 15,
    density: 5.514,
    orbitalInclination: 0.00
)

let marsAtmosphere = [
    Atmosphere(molar: "44", formula: "CO₂"),
    Atmosphere(molar: "28", formula: "N₂"),
    Atmosphere(molar: "18", formula: "H₂O")
]

let marsPlanet = Planet(
    name: NSLocalizedString("Mars", comment: ""),
    order: "4th",
    imageName: "smiling-mars",
    imageNameClosed: "smiling-mars",
    description: NSLocalizedString("The red planet, noted for its intriguing geological features.", comment: ""),
    visual: NSLocalizedString("After the 16th century", comment: ""),
    color: .colorMars,
    moons: 2,
    rings: 0,
    gravity: 4,
    escapeVelocity: "18,108",
    radius: "3.3895 × 10³",
    mass: "3.3895 × 10²³",
    volume: "1.63116 × 10¹¹",
    atmosphere: marsAtmosphere,
    expandedDescription: NSLocalizedString("Mars, known as the Red Planet due to its iron oxide-rich surface, features vast canyons, extinct volcanoes, and polar ice caps. Its potential for past or present life and suitability for human exploration make it a focal point of planetary science and exploration missions.", comment: ""),
    averageTemperature: -63,
    density: 3.9335,
    orbitalInclination: 1.85
)

let jupiterAtmosphere = [
    Atmosphere(molar: "2", formula: "H₂"),
    Atmosphere(molar: "4", formula: "He")
]

let jupiterPlanet = Planet(
    name: NSLocalizedString("Jupiter", comment: ""),
    order: "5th",
    imageName: "smiling-jupiter",
    imageNameClosed: "smiling-jupiter",
    description: NSLocalizedString("The largest planet, famous for its massive Great Red Spot storm.", comment: ""),
    visual: NSLocalizedString("After the 16th century", comment: ""),
    color: .colorJupiter,
    moons: 95,
    rings: 4,
    gravity: 25,
    escapeVelocity: "216,720",
    radius: "6.9911 × 10⁴",
    mass: "1.8981 × 10²⁷",
    volume: "1.43128 × 10¹⁵",
    atmosphere: jupiterAtmosphere,
    expandedDescription: NSLocalizedString("Jupiter, the largest planet in our solar system, is known for its immense size and the Great Red Spot, a persistent high-pressure storm. Its complex system of rings and moons, including the potentially habitable Europa, provides a rich field for studying planetary formation and dynamics.", comment: ""),
    averageTemperature: -145,
    density: 1.326,
    orbitalInclination: 1.30
)

let saturnAtmosphere = [
    Atmosphere(molar: "2", formula: "H₂"),
    Atmosphere(molar: "4", formula: "He")
]

let saturnPlanet = Planet(
    name: NSLocalizedString("Saturn", comment: ""),
    order: "6th",
    imageName: "smiling-saturn",
    imageNameClosed: "smiling-saturn",
    description: NSLocalizedString("The ringed planet, with a complex and beautiful ring system.", comment: ""),
    visual: NSLocalizedString("After the 16th century", comment: ""),
    color: .colorSaturn,
    moons: 83,
    rings: 7,
    gravity: 11,
    escapeVelocity: "129,924",
    radius: "5.8232 × 10⁴",
    mass: "5.6834 × 10²⁶",
    volume: "8.2713 × 10¹⁴",
    atmosphere: saturnAtmosphere,
    expandedDescription: NSLocalizedString("Saturn, the sixth planet from the Sun, is renowned for its extensive and visually striking ring system. Its unique features, including multiple moons with subsurface oceans, make it a key subject for understanding planetary rings, moon formation, and the potential for life beyond Earth.", comment: ""),
    averageTemperature: -178,
    density: 0.687,
    orbitalInclination: 2.48
)

let uranusAtmosphere = [
    Atmosphere(molar: "2", formula: "H₂"),
    Atmosphere(molar: "16", formula: "O₂")
]

let uranusPlanet = Planet(
    name: NSLocalizedString("Uranus", comment: ""),
    order: "7th",
    imageName: "smiling-uranus",
    imageNameClosed: "smiling-uranus",
    description: NSLocalizedString("An ice giant with a tilted rotation axis, causing extreme seasonal variations.", comment: ""),
    visual: NSLocalizedString("March 13, 1781", comment: ""),
    color: .colorUranus,
    moons: 27,
    rings: 13,
    gravity: 9,
    escapeVelocity: "76,968",
    radius: "2.5362 × 10⁴",
    mass: "8.6810 × 10²⁵",
    volume: "6.833 × 10¹³",
    atmosphere: uranusAtmosphere,
    expandedDescription: NSLocalizedString("Uranus, an ice giant with a unique sideways rotation, has an atmosphere rich in water, ammonia, and methane ices. Its unusual axial tilt and faint ring system provide insights into extreme seasonal changes and the diversity of planetary systems.", comment: ""),
    averageTemperature: -224,
    density: 1.271,
    orbitalInclination: 0.77
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

