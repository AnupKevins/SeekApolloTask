//
//  JobDetailModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 26/02/24.
//

import Foundation

protocol JobDetailModelProtocol {
    var jobTitle: String? { get set}
    var jobDescription: String? { get set}
    var jobLocation: String? { get set}
}

struct JobDetailModel {
    var jobTitle: String?
    var jobDescription: String?
    var jobLocation: String?
}
