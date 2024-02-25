//
//  ProfileViewModelTests.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest
@testable import SeekJobsTask

final class ProfileViewModelTests: XCTestCase {
    
    var viewModel: ProfileViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ProfileViewModel()
    }
    
    func testGetUsername() {
        UserDefaultManager.shared.username = "John"
        
        XCTAssertEqual(viewModel.getUserName(), "John")
    }

    func testGetPassword() {
        UserDefaultManager.shared.userPassword = "Password"
        
        XCTAssertEqual(viewModel.getPassword(), "Password")
    }
    
    func testClearDataOnLogout() {
        UserDefaultManager.shared.username = "John"
        UserDefaultManager.shared.userPassword = "Password"
        UserDefaultManager.shared.authToken = "123"
        UserDefaultManager.shared.isLoggedIn = true
        
        viewModel.onLogout()
        
        XCTAssertNil(UserDefaultManager.shared.authToken)
        XCTAssertFalse(UserDefaultManager.shared.isLoggedIn)
        XCTAssertNil(UserDefaultManager.shared.username)
        XCTAssertNil(UserDefaultManager.shared.userPassword)
    }

}
