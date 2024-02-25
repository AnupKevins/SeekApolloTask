//
//  MockLoginCoordinator.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import Foundation
@testable import SeekJobsTask
import UIKit

class MockLoginCoordinator: LoginCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {}
    // Implement other coordinator methods for testing, if needed
    
    func goToHomeCoordinator() {}
    
    func presentAlert(title: String, message: String) {}
}
