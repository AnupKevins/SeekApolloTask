//
//  JobsRequest.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation

struct JobsRequest {
    
    var limit: Int
    var page: Int
    
    init(limit: Int, page: Int) {
        self.limit = limit
        self.page = page
    }
}
