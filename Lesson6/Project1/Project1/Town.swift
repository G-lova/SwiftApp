//
//  Town.swift
//  Project1
//
//  Created by User on 01.02.2024.
//

import Foundation

struct Town: Codable {
    var townName: String
    var coords: Coordinate
    enum CodingKeys: String, CodingKey {
        case townName = "name"
        case coords
    }
}

struct Coordinate: Codable {
    var lat: Double?
    var lon: Double?
}
