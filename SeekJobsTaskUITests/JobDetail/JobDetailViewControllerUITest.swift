//
//  JobDetailViewControllerUITest.swift
//  SeekJobsTaskUITests
//
//  Created by Anup kumar sahu on 26/02/24.
//

import XCTest

final class JobDetailViewControllerUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["--uitesting"]
        app.launch()
    }

    func testJobDetailScreen() {

        let jobsTable = app.tables["JobsTable"]
        XCTAssertTrue(jobsTable.exists)

        // Assuming there's at least one cell in the table
        let firstCell = jobsTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)

        firstCell.tap()

        XCTAssertTrue(app.staticTexts["JobTitleIdentifier"].exists)
        XCTAssertTrue(app.staticTexts["JobDecriptionIdentifier"].exists)
        XCTAssertTrue(app.staticTexts["JobLocationIdentifier"].exists)
        XCTAssertTrue(app.buttons["ApplyButton"].exists)
    }
}
