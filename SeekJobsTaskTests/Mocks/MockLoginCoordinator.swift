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
    
    var presentedTitle: String?
    var presentedMessage: String?
    var didPresentAlert = false
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func presentAlert(title: String, message: String) {
        presentedTitle = title
        presentedMessage = message
        didPresentAlert = true
    }
}
