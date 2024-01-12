//
//  Photo.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation

struct Photo: Codable {
    var response: ResponsePhotos
}

struct ResponsePhotos: Codable {
    var count: Int
    var items: [PhotoItems]
}

struct PhotoItems: Codable {
    var url: String
}
