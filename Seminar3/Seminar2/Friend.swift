//
//  Friend.swift
//  Seminar3
//
//  Created by User on 26.12.2023.
//

import Foundation

struct Friend: Codable {
    var response: ResponseFriends
}

struct ResponseFriends: Codable {
    var count: Int
    var items: [Int]
}
