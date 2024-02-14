//
//  FileCacheTests.swift
//  VkSwiftAppTests
//
//  Created by User on 14.02.2024.
//

import XCTest
@testable import VkSwiftApp

class FileCacheTests: XCTestCase {
    
    var fileCache: FileCache!

    override func setUp()  {
        super.setUp()
        fileCache = FileCache()
    }

    override func tearDown() {
        fileCache = nil
        super.tearDown()
    }

    func testSave() {
        fileCache.save()
        XCTAssertTrue(true)
    }
    
    func testDelete() {
        let friend = FriendsModel(context: fileCache.persistentContainer.viewContext)
        fileCache.delete(object: friend)
        
        XCTAssertFalse(fileCache.persistentContainer.viewContext.registeredObjects.contains(friend))
    }
    
    func testAddFriends() {
        let friends: [FriendItems] = [FriendItems(id: 1, online: 1, first_name: "FirstName", last_name: "LastName", photo_50: "photo.jpg")]
        fileCache.addFriends(friends: friends)
        let fetchedFriends = fileCache.fetchFriends()
        
        XCTAssertEqual(fetchedFriends.count, 0)
    }
    
    func testLoadFriendsFromCoreData() {
        let expectation = self.expectation(description: "loadingFriends")
        fileCache.loadFriendsFromCoreData { (fetchedResultsController) in
            XCTAssertNotNil(fetchedResultsController)
            expectation.fulfill()
        }
    }

}
