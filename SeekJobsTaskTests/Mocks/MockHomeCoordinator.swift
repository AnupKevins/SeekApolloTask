//
//  MockHomeCoordinator.swift
//  SeekJobsTaskTests
//
//  Created by Anup kumar sahu on 25/02/24.
//

import Foundation
@testable import SeekJobsTask
import UIKit

class MockHomeCoordinator: HomeCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {}
    
    func presentAlert(title: String, message: String) {}
    
    func navigateToProfile() {}
}

