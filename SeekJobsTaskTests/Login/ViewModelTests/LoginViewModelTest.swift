//
//  LoginViewModelTest.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest
@testable import SeekJobsTask

final class LoginViewModelTest: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockLoginCoordinator: MockLoginCoordinator!
    var loginRepository: LoginRepositoryProtocol!
    
    override func setUpWithError() throws {
        
        mockLoginCoordinator = MockLoginCoordinator()
        loginRepository = LoginRepository()
        loginRepository.networkService.setGraphQLURL(
            URL(string: AppConstants.baseUrls.appBaseUrl)!
        )
        viewModel = LoginViewModel(
            coordinator: mockLoginCoordinator, loginRepositoryProtocol: loginRepository
        )
    }
    
    func testGetAuthTokenWithValidUser1() {
        
        let expectation = expectation(description: "Data is fetched successfully")
        
        viewModel.getAuthToken("user1", "Seeker1123") { result in
            
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
    
    func testGetAuthTokenWithValidUser2() {
        
        let expectation = expectation(description: "Data is fetched successfully")
        
        viewModel.getAuthToken("user2", "Seeker2123") { result in
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
    
    func testGetAuthTokenWithValidUser3() {
        
        let expectation = expectation(description: "Data is fetched successfully")
        
        viewModel.getAuthToken("user3", "Seeker3123") { result in
            
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
    
    func testGetAuthTokenWithInvalidValidUser() {
        
        let expectation = expectation(description: "Failed to fetch data.")
        
        viewModel.getAuthToken("user", "Seeker") { result in
            
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
        
        loginRepository.networkService.setGraphQLURL(URL(string: "http://localhost:300/")!)
        
        // Create an expectation for the expected failure
        let expectation = expectation(description: "Data fetching should fail")
        
        viewModel.getAuthToken("user", "Seeker") { result in
            
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
    
    func testLoginValidationWhenUsernameIsEmpty() {
        let value = viewModel.validateUserCredentials("", "123")
        XCTAssertEqual(value, .usernamePasswordEmpty)
    }
    
    func testLoginValidationWhenPasswordIsEmpty() {
        let value = viewModel.validateUserCredentials("user", "")
        XCTAssertEqual(value, .usernamePasswordEmpty)
    }
    
    func testLoginValidationWhenUserPasswordNotEmpty() {
        let value = viewModel.validateUserCredentials("user", "pass")
        XCTAssertEqual(value, .valid)
    }
}
