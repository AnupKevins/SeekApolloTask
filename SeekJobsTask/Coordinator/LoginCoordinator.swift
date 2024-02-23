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
        let loginViewController = LoginViewController()
        
        loginViewController.loginViewModel = LoginViewModel(
            coordinator: self,
            loginRepositoryProtocol: LoginRepository()
        )
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goToHomeCoordinator() {

        let loginCoordinator = HomeCoordinator(navigationController: self.navigationController)
        
        loginCoordinator.start()
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
                    // Additional handling can be added here if needed
                    self?.navigationController.topViewController?.dismiss(animated: true)
                }
            )

            alertController.addAction(okAction)

            // Present the alert from the topmost view controller
            navigationController.topViewController?.present(alertController, animated: true, completion: nil)
        }
}
