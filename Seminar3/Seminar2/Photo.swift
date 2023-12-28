//
//  Friend.swift
//  Seminar3
//
//  Created by User on 26.12.2023.
//

import Foundation

struct Photo: Codable {
    var response: ResponsePhotos
}

struct ResponsePhotos: Codable {
    var count: Int
    var items: [Int]
}
