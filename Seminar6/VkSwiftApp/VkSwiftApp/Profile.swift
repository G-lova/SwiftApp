//
//  Profile.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation

struct Profile: Codable {
    var response: [ProfileItems]
}

struct ProfileItems: Codable {
    var first_name: String
    var last_name: String
    var photo_200: String
}
