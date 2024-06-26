//
//  Card.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import Foundation
import SwiftUI

struct ImageViewCard: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var subtitle: String
    var imageName: String
    var color: Color
}


var imageList: [ImageViewCard] = [
    ImageViewCard(title: "July 2024 Update", subtitle: "Now on Watch", imageName: "home-banner-1", color: Color(hex: 0x756884)),
    ImageViewCard(title: "August 2024", subtitle: "Space News, Augmented Reality", imageName: "home-banner-3", color: Color(hex: 0x4D3C30)),
    ImageViewCard(title: "November 2024", subtitle: "Moons, Dwarf Planets", imageName: "home-banner-4", color: Color(hex: 0x4D3C30))

    /**
    ImageViewCard(title: "Now Available: v1.1", subtitle: "Explore the change log", imageName: "home-banner-0", color: Color(hex: 0x000000)),
    ImageViewCard(title: "The Lagoon Nebula", subtitle: "Discovered by Giovanni Hodierna", imageName: "home-banner-1", color: Color(hex: 0x756884)),
    ImageViewCard(title: "The Bubble Nebula", subtitle: "Discovered by William Herschel", imageName: "home-banner-2", color: Color(hex: 0x016A9B)),
    ImageViewCard(title: "The Cone Nebula", subtitle: "Discovered by William Herschel", imageName: "home-banner-3", color: Color(hex: 0x511D31)),
    ImageViewCard(title: "The Orion Nebula", subtitle: "Discovered by Peiresc", imageName: "home-banner-4", color: Color(hex: 0x4D3C30))
     */
]
