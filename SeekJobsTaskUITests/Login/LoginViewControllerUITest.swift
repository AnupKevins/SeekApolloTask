//
//  LoginViewControllerUITest.swift
//  SeekJobsTaskUITests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest
@testable import SeekJobsTask

final class LoginViewControllerUITest: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testInitialState() throws {
        XCTAssertTrue(app.textFields["Username"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
    }
}
