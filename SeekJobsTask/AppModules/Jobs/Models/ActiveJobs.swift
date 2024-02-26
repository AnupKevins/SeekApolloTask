//
//  ActiveJobs.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation

// MARK: - Active
struct ActiveJobs {
    var hasNext: Bool?
    var jobs: [InternalJob]?
}

// MARK: - Job
struct InternalJob {
    var id, description: String?
    var haveIApplied: Bool?
    var industry, location: Int?
    var positionTitle: String?
    var salaryRange: SalaryRange?
    
    var locationString: String? {
        if let location = location {
            return String(location)
        }
        return ""
    }
}

// MARK: - SalaryRange
struct SalaryRange {
    var max, min: Int?
}
