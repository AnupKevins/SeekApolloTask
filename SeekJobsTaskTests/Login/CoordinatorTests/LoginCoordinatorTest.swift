//
//  LoginCoordinatorTest.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest
@testable import SeekJobsTask

final class LoginCoordinatorTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testStart() {
        // Given
        let navigationController = UINavigationController()
        let coordinator = LoginCoordinator(navigationController: navigationController)
        
        // When
        let vc = coordinator.start()
        
        XCTAssertTrue(vc is LoginViewController, "Top view controller should be LoginViewController")
    }
    
    func testPresentAlert() {
        let navigationController = UINavigationController()
        let coordinator = LoginCoordinator(navigationController: navigationController)
        
        // When
        coordinator.presentAlert(title: "Alert", message: "detail")
        
        XCTAssertTrue(navigationController.presentationController != nil)
    }
}
