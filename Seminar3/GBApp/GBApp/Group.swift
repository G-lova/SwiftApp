//
//  Group.swift
//  GBApp
//
//  Created by User on 30.12.2023.
//

import Foundation

struct Group: Codable {
    var response: ResponseGroups
}

struct ResponseGroups: Codable {
    var count: Int
    var items: [Int]
}
