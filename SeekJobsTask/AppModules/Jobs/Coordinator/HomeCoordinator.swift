//
//  JobsCoordinator.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    var navigationController : UINavigationController { get set }
    
    func start()
    
    func presentAlert(title: String, message: String)
    
    func navigateToProfile()
    
    func navigateToJobDetail(jobDetailModel: JobDetailModel)
}

class HomeCoordinator: HomeCoordinatorProtocol {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let jobsViewController = JobsFactory.createJobsViewController()
        
        jobsViewController.jobsViewModel = JobsFactory.createJobsViewModel(
            homeCoordinator: self
        )
        
        navigationController.pushViewController(jobsViewController, animated: true)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self] _ in
                self?.navigationController.topViewController?.dismiss(animated: true)
            }
        )
        
        alertController.addAction(okAction)
        navigationController.topViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToProfile() {
        let profileViewController = JobsFactory.createProfileViewController()
        profileViewController.profileViewModel = JobsFactory.createProfileViewModel()
        
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func navigateToJobDetail(jobDetailModel: JobDetailModel) {
        let jobsDetailViewController = JobsFactory.createJobDetailViewController()
        jobsDetailViewController.jobDetailViewModel = JobsFactory.createJobDetailViewModel(jobDetailModel: jobDetailModel)
        
        navigationController.pushViewController(jobsDetailViewController, animated: true)
    }
}

