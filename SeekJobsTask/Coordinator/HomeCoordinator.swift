//
//  JobsCoordinator.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let jobsViewController = JobsViewController()
        
        jobsViewController.jobsViewModel = JobsViewModel(coordinator: self)
        
        navigationController.pushViewController(jobsViewController, animated: true)
    }
}

