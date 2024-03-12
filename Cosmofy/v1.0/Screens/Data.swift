//
//  Data.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 2/9/24.
//

import Foundation
import SwiftUI

struct PlanetData: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    
    var label1: String
    var label2: String
    
    var number: String
    var rings: String
    var moons: String
    
    var gravity: String
    var atmosphere: String
    var radius: String
    var density: String
    var volume: String
    var mass: String
    var au: String
    var other: String
    
}
