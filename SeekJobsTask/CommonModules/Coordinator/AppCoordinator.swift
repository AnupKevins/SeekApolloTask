//
//  AppCoordinator.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    private let window: UIWindow
    
    var navigationController: UINavigationController
    
    init(window: UIWindow, 
         navigationController: UINavigationController = UINavigationController()
    ) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start()  {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if UserDefaultManager.shared.isLoggedIn {
            let homeCoordinatorVC = getJobVC()
            navigationController.setViewControllers([homeCoordinatorVC], animated: true)
        } else {
            let loginCoordinatorVC = getLoginVC()
            navigationController.setViewControllers([loginCoordinatorVC], animated: true)
        }
    }
    
    private func getLoginVC() -> UIViewController {
        
        let loginCoordinator = LoginFactory.createLoginCoordinator(
            navigationController: self.navigationController
        )
        
        return loginCoordinator.start()
    }
    
    private func getJobVC() -> UIViewController {

        let homeCoordinator = JobsFactory.createHomeCoordinator(
            navigationController: self.navigationController
        )
        
        return homeCoordinator.start()
    }
}
