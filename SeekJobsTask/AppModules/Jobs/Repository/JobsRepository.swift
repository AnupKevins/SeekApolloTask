//
//  JobsRepository.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation
import Apollo
import JobsAPI

protocol JobsRepositoryProtocol {
    func fetchActiveJobs(limit: Int, page: Int, completion: @escaping (Result<ActiveJobs, AppError>) -> Void)
}

struct JobsRepository: JobsRepositoryProtocol {
    func fetchActiveJobs(limit: Int, page: Int, completion: @escaping (Result<ActiveJobs, AppError>) -> Void) {
        
        let query = GetJobsQuery(limit: .some(limit), page: .some(page))
        
        NetworkService.shared.apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
            
                if let active = graphQLResult.data?.active {
                    
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
    
   private func getJobs(active: GetJobsQuery.Data.Active) -> [InternalJob] {
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
    
    private func getSalaryRange(salaryRange: GetJobsQuery.Data.Active.Job.SalaryRange?) -> SalaryRange? {
        
        return SalaryRange(max: salaryRange?.max, min: salaryRange?.min)
    }
    
}
