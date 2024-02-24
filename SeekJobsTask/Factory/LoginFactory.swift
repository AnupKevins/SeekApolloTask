//
//  LoginFactory.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

protocol LoginFactoryProtocol {
    
    func createLoginCoordinator(
        navigationController: UINavigationController
    ) -> LoginCoordinator
    
    func createLoginViewController() -> LoginViewController
    
    func createLoginViewModel(loginCoordinator: LoginCoordinator) -> LoginViewModel
    
    func createLoginRepository() -> LoginRepositoryProtocol
}
 
class LoginFactory: LoginFactoryProtocol {
   
    func createLoginCoordinator(
        navigationController: UINavigationController
    ) -> LoginCoordinator {
        
        return LoginCoordinator(
            navigationController: navigationController
        )
    }
    
    func createLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    func createLoginViewModel(loginCoordinator: LoginCoordinator) -> LoginViewModel {
        return LoginViewModel(
            coordinator: loginCoordinator,
            loginRepositoryProtocol: createLoginRepository()
        )
    }
    
    func createLoginRepository() -> LoginRepositoryProtocol {
        return LoginRepository()
    }
    
}
