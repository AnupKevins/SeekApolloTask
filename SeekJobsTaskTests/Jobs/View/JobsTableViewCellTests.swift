//
//  JobsTableViewCellTests.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest
@testable import SeekJobsTask

final class JobsTableViewCellTests: XCTestCase {

    var cell: JobsTableViewCell!

        override func setUp() {
            super.setUp()
            cell = JobsTableViewCell(style: .default, reuseIdentifier: JobsTableViewCell.jobsCellStrIdentifier)
        }

        override func tearDown() {
            super.tearDown()
            cell = nil
        }

        func testConfigureCell() {
            // Given
            let titleText = "title"
            let subtitleText = "subtitle"
            let descriptionText = "description"
            let applied = true

            // When
            cell.configure(
                withTitle: titleText,
                subtitle: subtitleText,
                description: descriptionText,
                applied: applied
            )

            // Then
            XCTAssertEqual(cell.titleLabel.text, titleText)
            XCTAssertEqual(cell.subtitleLabel.text, subtitleText)
            XCTAssertEqual(cell.descriptionLabel.text, descriptionText)
            XCTAssertFalse(cell.appliedLabel.isHidden)
        }

}
