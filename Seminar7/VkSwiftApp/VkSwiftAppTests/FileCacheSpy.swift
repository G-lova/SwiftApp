//
//  FileCacheSpy.swift
//  VkSwiftAppTests
//
//  Created by User on 14.02.2024.
//

import XCTest
import CoreData
@testable import VkSwiftApp

class FileCacheSpy: FileCache {

    var isCalled = false
    
    override func loadFriendsFromCoreData (completion: @escaping( NSFetchedResultsController<FriendsModel>) -> Void) {
        isCalled = true
        let fetchedResultsController = NSFetchedResultsController<FriendsModel>()
        completion(fetchedResultsController)
    }

}
