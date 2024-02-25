//
//  ProfileViewControllerUITest.swift
//  SeekJobsTaskUITests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest

final class ProfileViewControllerUITest: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["--uitesting"]
        app.launch()
    }

    func testProfileViewUIElements() {
        let profileButton = app.navigationBars.buttons["Profile"]
        profileButton.tap()
        
        XCTAssertTrue(app.staticTexts["UsernameLabel"].exists)
        XCTAssertTrue(app.secureTextFields["PasswordTextField"].exists)
        XCTAssertTrue(app.buttons["UpdateButton"].exists)
        XCTAssertTrue(app.buttons["LogoutButton"].exists)
    }
    
    func testUpdatePassword() {
        let profileButton = app.navigationBars.buttons["Profile"]
        profileButton.tap()
        
        let newPassword = "newPassword123"
        
        app.secureTextFields["PasswordTextField"].tap()
        app.secureTextFields["PasswordTextField"].typeText(newPassword)
        app.buttons["UpdateButton"].tap()
        
        XCTAssertEqual(app.secureTextFields["PasswordTextField"].value as! String, "")
    }

    func testLogout() {
        let profileButton = app.navigationBars.buttons["Profile"]
        profileButton.tap()
        
        app.buttons["LogoutButton"].tap()
        
        XCTAssertTrue(app.buttons["Login"].exists)
    }
}
