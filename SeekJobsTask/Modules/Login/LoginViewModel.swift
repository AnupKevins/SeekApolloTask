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
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private (set) var postsAuthToken: String = ""
    
//    func fetch() {
//        // fetch posts
//        objectWillChange.send()
//        // assign new data to the posts variable
//    }
    
    init(
        coordinator: LoginCoordinator?,
        loginRepositoryProtocol: LoginRepositoryProtocol?
    ) {
        self.coordinator = coordinator
        self.loginRepositoryProtocol = loginRepositoryProtocol
    }
    
    func getAuthToken(_ username: String, _ password: String) {
        self.loginRepositoryProtocol?.authenticate(username: username, password: password, completion: { [weak self] result in
            
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
        objectWillChange.send()
        navigateToHomeJobsScreen()
    }
    
    private func performActionOnFailure() {
        showAlert()
    }
    
    func navigateToHomeJobsScreen() {
        coordinator?.goToHomeCoordinator()
    }
    
    func validateUserCredentials(_ username: String, _ password: String) -> LoginValidation {
        if username.isEmpty || password.isEmpty {
            return .usernamePasswordEmpty
        }
        return .valid
    }
    
    func showAlert() {
        coordinator?.presentAlert(
            title: AppConstants.Login.invalidCredentialTitle, 
            message: AppConstants.Login.invalidCredentialMessage
        )
    }
}
