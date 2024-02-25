//
//  InternalJobTest.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 26/02/24.
//

import XCTest
@testable import SeekJobsTask

final class InternalJobTest: XCTestCase {
    
    func testLocationString() {
    
        let jobWithLocation = InternalJob(id: "1", description: "Description", haveIApplied: true, industry: 123, location: 456, positionTitle: "Engineer", salaryRange: SalaryRange(max: 70000, min: 50000))
        
        let jobWithoutLocation = InternalJob(id: "2", description: "Another Description", haveIApplied: false, industry: 789, location: nil, positionTitle: "Designer", salaryRange: SalaryRange(max: 80000, min: 60000))
        
        
        let locationStringWithLocation = jobWithLocation.locationString
        let locationStringWithoutLocation = jobWithoutLocation.locationString
        
        
        XCTAssertEqual(locationStringWithLocation, "456", "Location string should be '456' when location is present")
        XCTAssertEqual(locationStringWithoutLocation, "", "Location string should be empty when location is nil")
    }
    
}
