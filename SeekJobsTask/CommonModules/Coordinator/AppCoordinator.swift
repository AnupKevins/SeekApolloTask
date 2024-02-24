//
//  AppCoordinator.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        if UserDefaultManager.shared.isLoggedIn {
            goToHomeCoordinator()
        } else {
            goToLoginCoordinator()
        }
    }
    
    func goToLoginCoordinator(){
              
        let loginCoordinator = LoginFactory.createLoginCoordinator(
            navigationController: navigationController
        )
        
        loginCoordinator.start()
    }
    
    func goToHomeCoordinator() {

        let homeCoordinator = JobsFactory.createHomeCoordinator(
            navigationController: self.navigationController
        )
        
        homeCoordinator.start()
    }
}
