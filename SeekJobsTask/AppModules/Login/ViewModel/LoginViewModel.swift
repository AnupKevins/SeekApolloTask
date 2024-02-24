//
//  LoginViewModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    var loginRepositoryProtocol: LoginRepositoryProtocol?
    var coordinator: LoginCoordinator?
    
    let authTokenWillChange = PassthroughSubject<Void, Never>()
    
    private (set) var postsAuthToken: String = ""
    
    init(
        coordinator: LoginCoordinator?,
        loginRepositoryProtocol: LoginRepositoryProtocol?
    ) {
        self.coordinator = coordinator
        self.loginRepositoryProtocol = loginRepositoryProtocol
    }
    
    func getAuthToken(_ username: String, _ password: String) {
        
        let loginRequest = LoginRequest(username: username, password: password)
        self.loginRepositoryProtocol?.authenticate(loginRequest: loginRequest, completion: { [weak self] result in
            
            switch result {
            case .success(let value):
                self?.performActionOnSuccess(value)
            case .failure(_):
                self?.performActionOnFailure()
            }
        })
    }
    
    private func performActionOnSuccess(_ value: String) {
        postsAuthToken = value
        authTokenWillChange.send()
    }
    
    private func performActionOnFailure() {
        showAlert()
        authTokenWillChange.send()
    }
    
//    func navigateToHomeJobsScreen() {
//        coordinator?.goToHomeCoordinator()
//    }
    
    func validateUserCredentials(_ username: String, _ password: String) -> LoginValidation {
        if username.isEmpty || password.isEmpty {
            return .usernamePasswordEmpty
        }
        return .valid
    }
    
    func showAlert() {
        coordinator?.presentAlert(
            title: LoginConstants.Login.invalidCredentialTitle,
            message: LoginConstants.Login.invalidCredentialMessage
        )
    }
}
