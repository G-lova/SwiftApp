//
//  Photo.swift
//  GBApp
//
//  Created by User on 30.12.2023.
//

import Foundation

struct Photo: Codable {
    var response: ResponsePhotos
}

struct ResponsePhotos: Codable {
    var count: Int
    var items: [Int]
}
