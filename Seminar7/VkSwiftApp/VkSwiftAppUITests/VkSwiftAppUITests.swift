//
//  VkSwiftAppUITests.swift
//  VkSwiftAppUITests
//
//  Created by User on 14.02.2024.
//

import XCTest
import WebKit

class VkSwiftAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testTabClick() {
        let tabBar = app.tabBars["TabBarController"]
        let friendsVCButton = tabBar.buttons["Friends"]
        friendsVCButton.tap()
        tabBar.buttons["Groups"].tap()
        tabBar.buttons["Photos"].tap()
    }
}
