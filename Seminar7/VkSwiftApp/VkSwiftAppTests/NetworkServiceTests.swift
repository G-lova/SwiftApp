//
//  NetworkServiceTests.swift
//  VkSwiftAppTests
//
//  Created by User on 14.02.2024.
//

import XCTest
@testable import VkSwiftApp

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var mockURLSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        mockURLSession = URLSessionMock()
//        networkService.urlSession = mockURLSession
    }

    func testsGetFriendsData() {
        let expectation = self.expectation(description: "Get Friends Data")
        
        networkService.getFriendsData(completion: { (friends) in
            XCTAssertNotNil(friends)
            XCTAssertGreaterThan(friends.count, 0)
            expectation.fulfill()
        }, errorHandler: {
            XCTFail("Error handler called")
            expectation.fulfill()
        })
        
        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testsGetGroupsData() {
        let expectation = self.expectation(description: "Get Groups Data")
        
        networkService.getGroupsData(groupCompletion: { (groups) in
            XCTAssertNotNil(groups)
            XCTAssertGreaterThan(groups.count, 0)
            expectation.fulfill()
        })
        
        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetPhotosData() {
        let expectation = self.expectation(description: "Get Photos Data")
        let testPhotosData = Data()
        
        mockURLSession.data = testPhotosData
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        networkService.getPhotosData(photoCompletion: { (photos) in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetProfileDataSuccess() {
        let expectation = self.expectation(description: "Get profile data success")
        networkService.getProfileData(userID: "12345") { profileItems in
            XCTAssertNotNil(profileItems)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProfileDataFail() {
        let expectation = self.expectation(description: "Get profile data fail")
        networkService.getProfileData(userID: "nonexistent") { profileItems in
            XCTAssertTrue(profileItems.isEmpty)
            expectation.fulfill()
        }
    }
    
}
