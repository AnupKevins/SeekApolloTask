//
//  LoginCoordinator.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {

    var navigationController: UINavigationController
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let loginViewController = LoginFactory.createLoginViewController()
        
        loginViewController.loginViewModel = LoginFactory.createLoginViewModel(
            loginCoordinator: self
        )
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goToHomeCoordinator() {

        let homeCoordinator = JobsFactory.createHomeCoordinator(
            navigationController: self.navigationController
        )
        
        homeCoordinator.start()
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
}
