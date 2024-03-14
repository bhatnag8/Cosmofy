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
    ImageViewCard(title: "The Lagoon Nebula", subtitle: "Discovered by Giovanni Hodierna", imageName: "home-banner-1", color: Color(hex: 0x756884)),
    ImageViewCard(title: "The Bubble Nebula", subtitle: "Discovered by William Herschel", imageName: "home-banner-2", color: Color(hex: 0x016A9B)),
    ImageViewCard(title: "The Cone Nebula", subtitle: "Discovered by William Herschel", imageName: "home-banner-3", color: Color(hex: 0x511D31)),
    ImageViewCard(title: "The Orion Nebula", subtitle: "Discovered by Peiresc", imageName: "home-banner-4", color: Color(hex: 0x4D3C30))
]