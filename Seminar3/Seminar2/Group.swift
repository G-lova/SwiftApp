//
//  Friend.swift
//  Seminar3
//
//  Created by User on 26.12.2023.
//

import Foundation

struct Group: Codable {
    var response: ResponseGroups
}

struct ResponseGroups: Codable {
    var count: Int
    var items: [Int]
}
