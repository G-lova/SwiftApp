//
//  Group.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation

struct Group: Codable {
    var response: ResponseGroups
}

struct ResponseGroups: Codable {
    var count: Int
    var items: [GroupsItems]
}

struct GroupsItems: Codable {
//    var id: Int
    var name: String
    var description: String?
    var photo_50: String
//    var photo_100: String
//    var photo_200: String
}
