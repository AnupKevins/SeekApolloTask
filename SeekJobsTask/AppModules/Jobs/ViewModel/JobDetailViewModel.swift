//
//  JobDetailViewModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 26/02/24.
//

import Foundation

protocol JobDetailViewModelProtocol {
    var jobDetailModel: JobDetailModel { get set }
}

class JobDetailViewModel: JobDetailViewModelProtocol {
    var jobDetailModel: JobDetailModel
    
    init(jobDetailModel: JobDetailModel) {
        self.jobDetailModel = jobDetailModel
    }
}
