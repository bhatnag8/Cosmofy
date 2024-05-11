//
//  Event.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/7/24.
//

import Foundation

struct Event: Identifiable, Decodable, Hashable {
    var id: String
    var title: String
    var description: String?
    var link: URL
    var closed: String?
    var categories: [Category]
    var sources: [Source]
    var geometry: [Geometry]
    
    struct Category: Identifiable, Decodable, Hashable {
        var id: String
        var title: String
    }

    struct Source: Identifiable, Decodable, Hashable {
        var id: String
        var url: URL
    }

    struct Geometry: Hashable, Decodable {
        var magnitudeValue: Double?  // Optional magnitude value
        var magnitudeUnit: String?   // Optional magnitude unit
        var date: String
        var type: String
        var coordinates: [Double]
    }
}

struct EventsResponse: Decodable {
    var title: String
    var description: String?
    var link: URL
    var events: [Event]
}
