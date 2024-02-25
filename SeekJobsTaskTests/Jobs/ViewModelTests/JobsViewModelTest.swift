//
//  JobsViewModel.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest
@testable import SeekJobsTask

final class JobsViewModelTest: XCTestCase {
    
    var viewModel: JobsViewModel!
    var mockHomeCoordinator: MockHomeCoordinator!
    var jobRepository: JobsRepositoryProtocol!
    
    override func setUpWithError() throws {
        
        mockHomeCoordinator = MockHomeCoordinator()
        jobRepository = JobsRepository()
        jobRepository.networkService.setGraphQLURL(
            URL(string: AppConstants.baseUrls.appBaseUrl)!
        )
        viewModel = JobsViewModel(
            coordinator: mockHomeCoordinator, jobsRepositoryProtocol: jobRepository
        )
    }
    
    func testFetchDataSuccessFully() {
        
        let expectation = expectation(description: "Data is fetched successfully")
        
        viewModel.fetchActiveJobs(page: viewModel.currentPage) { result in
            
            switch result {
            case .success(let data):
                // Verify the data or any other assertions
                XCTAssertNotNil(data)
                
                // Fulfill the expectation
                expectation.fulfill()
                
            case .failure(let error):
                // Handle the failure case or make assertions if needed
                XCTFail("Failed to fetch data. Error: \(error)")
            }
        }
        
        // Wait for the expectation to be fulfilled, or timeout after a certain duration
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchNoDataWhenPageNumberNotValid() {
        
        let expectation = expectation(description: "Failed to fetch data.")
        
        viewModel.fetchActiveJobs(page: 10) { result in
            
            switch result {
            case .success(let data):
                // Verify the data or any other assertions
                XCTAssertNil(data)
                
            case .failure(let error):
                // Handle the failure case or make assertions if needed
                XCTAssertNotNil(error)
                // Fulfill the expectation
                expectation.fulfill()
            }
        }
        
        // Wait for the expectation to be fulfilled, or timeout after a certain duration
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDataFailure() {
        
        jobRepository.networkService.setGraphQLURL(URL(string: "http://localhost:300/")!)
        
        // Create an expectation for the expected failure
        let expectation = expectation(description: "Data fetching should fail")
        
        viewModel.fetchActiveJobs(page: viewModel.currentPage) { result in
            
            switch result {
            case .success(let data):
                
                XCTAssertNil(data)
                
            case .failure(let error):
                
                XCTAssertNotNil(error)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchAdditionalDataIfNeeded() {
        
        let expectation = expectation(description: "Data is fetched successfully")
        
        var fetchCountWithPagination = 1
        
        viewModel.fetchActiveJobs(page: viewModel.currentPage) { result in
            
            switch result {
            case .success(let data):
                fetchCountWithPagination += 1
                self.fetchAdditionalDataWithHasNext(activeJobs: data)
                print("page count\(self.viewModel.currentPage)")
                XCTAssertEqual(self.viewModel.currentPage, fetchCountWithPagination)
                
                // Fulfill the expectation
                expectation.fulfill()
                
            case .failure(let error):
                // Handle the failure case or make assertions if needed
                XCTFail("Failed to fetch data. Error: \(error)")
            }
        }
        
        // Wait for the expectation to be fulfilled, or timeout after a certain duration
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func fetchAdditionalDataWithHasNext(activeJobs: ActiveJobs) {
        if let indexpath = getIndexPath(activeJobs: activeJobs) {
            viewModel.isLoading = false
            viewModel.fetchAdditionalDataIfNeeded(for: indexpath)
        }
    }
    
    func getIndexPath(activeJobs: ActiveJobs) -> IndexPath? {
        var indexpath: IndexPath?
        if let jobList = activeJobs.jobs {
            indexpath = IndexPath(row: jobList.count - 1, section: 0)
        }
        return indexpath
    }
}
