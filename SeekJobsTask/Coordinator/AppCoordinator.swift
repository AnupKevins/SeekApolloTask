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
        goToLoginCoordinator()
    }
    
    func goToLoginCoordinator(){
              
        let loginCoordinator = LoginCoordinator(navigationController: self.navigationController)
        
        loginCoordinator.start()
    }
}
