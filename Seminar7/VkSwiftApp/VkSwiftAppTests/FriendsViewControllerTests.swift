//
//  FriendsViewControllerTests.swift
//  VkSwiftAppTests
//
//  Created by User on 14.02.2024.
//

import XCTest
import CoreData
@testable import VkSwiftApp

class FriendsViewControllerTests: XCTestCase {
    
    var sut: FriendsViewController!
    

    override func setUp() {
        super.setUp()
        
        sut = FriendsViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewDidLoadSetsTitle() {
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "Friends")
    }

    func testProfileButtonTappedNavigation()  {
        sut.profileButtonTapped()
        
        XCTAssertTrue(sut.navigationController?.view.layer.animation(forKey: "CATransition") != nil)
    }
    
    func testLoadFriendsFromCoreDataCalled() {
        let fileCacheSpy = FileCacheSpy()
        sut.fileCache = fileCacheSpy
        sut.setupLoadFriendsFromCoreData()
        
        XCTAssertTrue(fileCacheSpy.isCalled)
    }
    
    func testNumberOfSection() {
        let numberOfSections = sut.numberOfSections(in: sut.tableView)
        
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfRowsInSection() {
        let numberOfRowsInSection = sut.tableView(sut.tableView, numberOfRowsInSection:0)
        
        XCTAssertEqual(numberOfRowsInSection, 0)
    }

}
