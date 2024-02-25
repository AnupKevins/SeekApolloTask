//
//  JobsFactory.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 25/02/24.
//

import Foundation
import UIKit

protocol JobsFactoryProtocol {
    
    static func createHomeCoordinator(
        navigationController: UINavigationController
    ) -> HomeCoordinator
    
    static func createJobsViewController() -> JobsViewController
    
    static func createJobsViewModel(homeCoordinator: HomeCoordinator) -> JobsViewModel
    
    static func createJobsRepository() -> JobsRepositoryProtocol
}
 
class JobsFactory: JobsFactoryProtocol {
   
    static func createHomeCoordinator(
        navigationController: UINavigationController
    ) -> HomeCoordinator {
        
        return HomeCoordinator(
            navigationController: navigationController
        )
    }
    
    static func createJobsViewController() -> JobsViewController {
        return JobsViewController()
    }
    
    static func createJobsViewModel(homeCoordinator: HomeCoordinator) -> JobsViewModel {
        return JobsViewModel(
            coordinator: homeCoordinator,
            jobsRepositoryProtocol: createJobsRepository()
        )
    }
    
    static func createJobsRepository() -> JobsRepositoryProtocol {
        return JobsRepository()
    }
    
}