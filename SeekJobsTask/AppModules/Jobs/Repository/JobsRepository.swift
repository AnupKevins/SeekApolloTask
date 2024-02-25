//
//  JobsRepository.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation
import JobsAPI

protocol JobsRepositoryProtocol {
    func fetchActiveJobs(jobsRequest: JobsRequest, completion: @escaping (Result<ActiveJobs, AppError>) -> Void)
}

struct JobsRepository: JobsRepositoryProtocol {
    func fetchActiveJobs(jobsRequest: JobsRequest, completion: @escaping (Result<ActiveJobs, AppError>) -> Void) {
        
        let query = GetJobsQuery(
            limit: .some(jobsRequest.limit),
            page: .some(jobsRequest.page)
        )
        
        let networkService = NetworkService.shared
            
        networkService.fetchDataWithGraphQLQuery(query: query) { result in
            switch result {
            case .success(let data):
            
                if let active = data?.active {
                    
                    let jobsArr = getJobs(active: active)
                    let activeJobs = ActiveJobs(hasNext: active.hasNext, jobs: jobsArr)
                    completion(.success(activeJobs))
                } else {
                    let appError = AppError.dataError(
                         description: "Invalid Response"
                     )
                    completion(.failure(appError))
                }
                
            case .failure(let error):
                // Handle network or other errors
                let appError = AppError.dataError(
                    description: error.localizedDescription
                 )
                 
                completion(.failure(appError))
            }
        }
    }
    
    private func getJobs(
        active: GetJobsQuery.Data.Active
    ) -> [InternalJob] {
        
        guard let jobs = active.jobs else { return [] }
        
        return jobs.compactMap { job in
            InternalJob(
                id: job?._id,
                description: job?.description,
                haveIApplied: job?.haveIApplied,
                industry: job?.industry,
                location: job?.location,
                positionTitle: job?.positionTitle,
                salaryRange: getSalaryRange(salaryRange: job?.salaryRange)
            )
        }
    }
    
    private func getSalaryRange(
        salaryRange: GetJobsQuery.Data.Active.Job.SalaryRange?
    ) -> SalaryRange? {
        
        return SalaryRange(max: salaryRange?.max, min: salaryRange?.min)
    }
    
}
