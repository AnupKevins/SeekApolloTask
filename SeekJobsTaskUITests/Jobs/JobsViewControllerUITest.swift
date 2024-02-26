//
//  JobsViewControllerUITest.swift
//  SeekJobsTaskUITests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest

final class JobsViewControllerUITest: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["home_uitesting"]
        app.launch()
    }

    func testTableViewExists() throws {
        let jobsTable = app.tables["JobsTable"]
        XCTAssertTrue(jobsTable.exists)
    }
    
    func testProfileButtonExists() throws {
        let profileButton = app.navigationBars.buttons["Profile"]
        XCTAssertTrue(profileButton.exists)
    }
    
    func testProfileButtonTapped() throws {
        let profileButton = app.navigationBars.buttons["Profile"]
        profileButton.tap()
        
        XCTAssertTrue(app.navigationBars["MyProfile"].exists)
    }
    
    func testTableViewCellExists() throws {
            let jobsTable = app.tables["JobsTable"]
            XCTAssertTrue(jobsTable.exists)

            // Assuming there's at least one cell in the table
            let firstCell = jobsTable.cells.element(boundBy: 0)
            XCTAssertTrue(firstCell.exists)

//            firstCell.tap()

    }
}
