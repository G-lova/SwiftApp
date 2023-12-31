//
//  Friend.swift
//  GBApp
//
//  Created by User on 30.12.2023.
//

import Foundation

struct Friend: Codable {
    var response: ResponseFriends
}

struct ResponseFriends: Codable {
    var count: Int
    var items: [Int]
}
