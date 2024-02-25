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
        app.launchArguments += ["login_uitesting"]
        app.launch()
    }
    
    func testInitialState() throws {
        XCTAssertTrue(app.textFields["Username"].exists)
        XCTAssertTrue(app.secureTextFields["PasswordTextField"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
    }
    
    func testSuccessfulLoginAndNavigateToJobsScreen() throws {
        
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("user1")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("Seeker1123")
        
        app.buttons["Login"].tap()
        
        XCTAssertTrue(app.navigationBars["ActiveJobs"].exists)
    }
    
    func testInvalidLoginAlertIsShown() throws {
        app.textFields["Username"].tap()
        app.textFields["Username"].typeText("invaliduser")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("invalidpassword")
        
        app.buttons["Login"].tap()

        XCTAssertTrue(app.buttons["OKButtonIdentifier"].exists)
    }
}
