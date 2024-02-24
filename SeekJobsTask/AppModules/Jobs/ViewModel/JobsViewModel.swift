//
//  JobsViewModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import Combine

protocol JobsViewModelProtocol {
    func fetchActiveJobs(page: Int)
}

class JobsViewModel: ObservableObject, JobsViewModelProtocol {

    var coordinator: HomeCoordinator?
    var jobsRepositoryProtocol: JobsRepositoryProtocol?
    var jobsSubject = PassthroughSubject<Void, Never>()
    private (set) var postsJobs: ActiveJobs?
    private (set) var jobList: [InternalJob] = []
    private var currentPage = 1
    var isLoading = false
        
    init(
        coordinator: HomeCoordinator?,
        jobsRepositoryProtocol: JobsRepositoryProtocol?
    ) {
        self.coordinator = coordinator
        self.jobsRepositoryProtocol = jobsRepositoryProtocol
    }
    
    func fetchActiveJobs(page: Int) {
        
        guard validateHasNext() else {
            return
        }
        isLoading = true
        
        let limit = JobsConstants.dataConstants.itemLimits
        
        self.jobsRepositoryProtocol?.fetchActiveJobs(limit: limit, page: page, completion: { [weak self] result in
            switch result {
            case .success(let activeJobs):
                self?.performActionOnSuccess(activeJobs)
            case .failure(_):
                self?.performActionOnFailure()
            }
        })
    }
    
    func fetchAdditionalDataIfNeeded(for indexPath: IndexPath) {
        let shouldLoadMore = indexPath.row == jobList.count - 1 && !isLoading

        if shouldLoadMore {
            currentPage += 1
            fetchActiveJobs(page: currentPage)
        }
    }
    
    private func validateHasNext() -> Bool {
        return postsJobs?.hasNext ?? true
    }
    
    func performActionOnSuccess(_ activeJobs: ActiveJobs) {
        sendValue(activeJobs)
    }
    
    func sendValue(_ value: ActiveJobs) {
        postsJobs = value
        if let jobs = value.jobs {
            jobList.append(contentsOf: jobs)
        }
        
        jobsSubject.send()
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
}
