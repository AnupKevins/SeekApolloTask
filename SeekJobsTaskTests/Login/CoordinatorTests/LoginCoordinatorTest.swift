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
        coordinator.start()
        
        // Then
        XCTAssertTrue(navigationController.viewControllers.count == 1, "Start should push one view controller")
        XCTAssertTrue(navigationController.topViewController is LoginViewController, "Top view controller should be LoginViewController")
    }
    
    func testPresentAlert() {
        let navigationController = UINavigationController()
        let coordinator = LoginCoordinator(navigationController: navigationController)
        
        coordinator.start()
        // When
        coordinator.presentAlert(title: "Alert", message: "detail")
        
        XCTAssertTrue(navigationController.presentationController != nil)
        
        XCTAssertTrue((navigationController.topViewController?.isModalInPresentation) != nil)
    }
}
