//
//  Friend.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation

struct Friend: Codable {
    var response: ResponseFriends
}

struct ResponseFriends: Codable {
    var count: Int
    var items: [FriendItems]
}

struct FriendItems: Codable {
    var id: Int64
//    var lists:[Int]
//    var track_code: String
    var online: Int16
    var first_name: String
    var last_name: String
//    var can_access_closed: Bool
//    var is_closed: Bool
    var photo_50: String
}
