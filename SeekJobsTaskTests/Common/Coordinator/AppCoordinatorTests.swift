//
//  AppCoordinatorTests.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import XCTest

@testable import SeekJobsTask

final class AppCoordinatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testStartWhenUserAlreadyLoggedIn() {
        // Given
        let navigationController = UINavigationController()
        let window = UIWindow()
        let coordinator = AppCoordinator(
            window: window,
            navigationController: navigationController
        )
        
        UserDefaultManager.shared.isLoggedIn = true
        // When
        coordinator.start()
        
        // Then
        XCTAssertTrue(navigationController.viewControllers.count == 1, "Start should push one view controller")
        XCTAssertTrue(navigationController.topViewController is JobsViewController, "Top view controller should be LoginViewController")
    }

    func testStartWhenUserNotLoggedIn() {
        // Given
        let navigationController = UINavigationController()
        let window = UIWindow()
        let coordinator = AppCoordinator(
            window: window,
            navigationController: navigationController
        )
        UserDefaultManager.shared.isLoggedIn = false
        // When
        coordinator.start()
        
        // Then
        XCTAssertTrue(navigationController.viewControllers.count == 1, "Start should push one view controller")
        XCTAssertTrue(navigationController.topViewController is LoginViewController, "Top view controller should be LoginViewController")
    }
}
