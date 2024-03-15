//
//  RotationData.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/14/24.
//

import Foundation
import SwiftUI

struct Position: Identifiable {
    var id = UUID()
    var days: Float
    var distance: Float
    var animate: Bool = false
}

var VenusData: [Position] = [
    Position(days: 0.0, distance: 45.99576),
    Position(days: 9.78, distance: 50.02168),
    Position(days: 19.56, distance: 58.40583),
    Position(days: 29.33, distance: 65.41255),
    Position(days: 39.11, distance: 69.28007),
    Position(days: 48.89, distance: 69.28007),
    Position(days: 58.67, distance: 65.41255),
    Position(days: 68.44, distance: 58.40583),
    Position(days: 78.22, distance: 50.02168),
    Position(days: 88.0, distance: 45.99576),

]

