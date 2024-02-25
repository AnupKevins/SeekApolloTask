//
//  JobDetailViewModelTests.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 26/02/24.
//

import XCTest
@testable import SeekJobsTask

final class JobDetailViewModelTests: XCTestCase {
    
    func testInitialization() {
        let jobDetailModel = JobDetailModel(jobTitle: "Title", jobDescription: "description", jobLocation: "17")
        let viewModel = JobDetailViewModel(jobDetailModel: jobDetailModel)
        
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.jobDetailModel.jobTitle, "Title")
        XCTAssertEqual(viewModel.jobDetailModel.jobDescription, "description")
        XCTAssertEqual(viewModel.jobDetailModel.jobLocation, "17")
    }
}

