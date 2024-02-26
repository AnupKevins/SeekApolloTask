//
//  LoginCoordinator.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol {
    var navigationController : UINavigationController { get set }
    
    func start() -> UIViewController
    
    func presentAlert(title: String, message: String)
}

class LoginCoordinator: LoginCoordinatorProtocol {

    var navigationController: UINavigationController
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() -> UIViewController {
        
        let loginViewController = LoginFactory.createLoginViewController()
        
        loginViewController.loginViewModel = LoginFactory.createLoginViewModel(
            loginCoordinator: self
        )
        
        return loginViewController
//
//        navigationController.pushViewController(loginViewController, animated: true)
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
        okAction.accessibilityLabel = "OKButtonIdentifier"
        alertController.addAction(okAction)
        navigationController.topViewController?.present(alertController, animated: true, completion: nil)
    }
}
