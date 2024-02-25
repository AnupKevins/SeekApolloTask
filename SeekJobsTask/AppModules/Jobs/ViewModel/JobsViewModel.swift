//
//  JobsViewModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import Combine

protocol JobsViewModelProtocol {
    func fetchActiveJobs(page: Int, completion: @escaping (Result<ActiveJobs, AppError>) -> Void)
    func fetchAdditionalDataIfNeeded(for indexPath: IndexPath)
}

class JobsViewModel: ObservableObject, JobsViewModelProtocol {

    var coordinator: HomeCoordinatorProtocol?
    var jobsRepositoryProtocol: JobsRepositoryProtocol?
    var jobsSubject = PassthroughSubject<Void, Never>()
    private (set) var postsJobs: ActiveJobs?
    private (set) var jobList: [InternalJob] = []
    var currentPage: Int = 1
    var isLoading = false
        
    init(
        coordinator: HomeCoordinatorProtocol?,
        jobsRepositoryProtocol: JobsRepositoryProtocol?
    ) {
        self.coordinator = coordinator
        self.jobsRepositoryProtocol = jobsRepositoryProtocol
    }
    
    func fetchActiveJobs(page: Int, completion: @escaping (Result<ActiveJobs, AppError>) -> Void) {
        
        isLoading = true
        
        let limit = JobsConstants.dataConstants.itemLimits
        
        let jobRequest = JobsRequest(limit: limit, page: page)
        
        self.jobsRepositoryProtocol?.fetchActiveJobs(jobsRequest: jobRequest, completion: { [weak self] result in
            switch result {
            case .success(let activeJobs):
                self?.performActionOnSuccess(activeJobs)
                completion(.success(activeJobs))
            case .failure(let error):
               //  self?.performActionOnFailure()
                completion(.failure(error))
            }
        })
    }
    
    func fetchAdditionalDataIfNeeded(for indexPath: IndexPath) {
        let shouldLoadMore = indexPath.row == jobList.count - 1 && !isLoading

        if shouldLoadMore && validateHasNext() {
            currentPage += 1
            //fetchActiveJobs(page: currentPage)
            jobsSubject.send()
        }
    }
    
    private func validateHasNext() -> Bool {
        return postsJobs?.hasNext ?? true
    }
    
   private func performActionOnSuccess(_ activeJobs: ActiveJobs) {
        updateJoblistAndPostJobs(activeJobs)
    }
    
    private func updateJoblistAndPostJobs(_ value: ActiveJobs) {
        postsJobs = value
        if let jobs = value.jobs {
            jobList.append(contentsOf: jobs)
        }
    }
    
    private func performActionOnFailure() {
        showAlert()
    }
    
    private func showAlert() {
        coordinator?.presentAlert(
            title: JobsConstants.textConstants.noResponseTitle,
            message: JobsConstants.textConstants.noResponseDescription
        )
    }
    
    func navigateToProfile() {
        coordinator?.navigateToProfile()
    }
}
