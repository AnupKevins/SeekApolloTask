//
//  LoginFactory.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import UIKit

protocol LoginFactoryProtocol {
    
   static func createLoginCoordinator(
        navigationController: UINavigationController
    ) -> LoginCoordinator
    
    static func createLoginViewController() -> LoginViewController
    
    static func createLoginViewModel(loginCoordinator: LoginCoordinator) -> LoginViewModel
    
    static func createLoginRepository() -> LoginRepositoryProtocol
}
 
class LoginFactory: LoginFactoryProtocol {
   
    static func createLoginCoordinator(
        navigationController: UINavigationController
    ) -> LoginCoordinator {
        
        return LoginCoordinator(
            navigationController: navigationController
        )
    }
    
    static func createLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    static func createLoginViewModel(loginCoordinator: LoginCoordinator) -> LoginViewModel {
        return LoginViewModel(
            coordinator: loginCoordinator,
            loginRepositoryProtocol: createLoginRepository()
        )
    }
    
    static func createLoginRepository() -> LoginRepositoryProtocol {
        return LoginRepository()
    }
    
}
