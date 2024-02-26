//
//  LoginViewModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var loginRepositoryProtocol: LoginRepositoryProtocol?
    var coordinator: LoginCoordinatorProtocol?
        
    private (set) var postsAuthToken: String = ""
    
    init(
        coordinator: LoginCoordinatorProtocol?,
        loginRepositoryProtocol: LoginRepositoryProtocol?
    ) {
        self.coordinator = coordinator
        self.loginRepositoryProtocol = loginRepositoryProtocol
    }
    
    func getAuthToken(
        _ username: String,
        _ password: String,
        completion: @escaping (Result<String, AppError>) -> Void
    ) {
        
        let loginRequest = LoginRequest(username: username, password: password)
        self.loginRepositoryProtocol?.authenticate(loginRequest: loginRequest, completion: { [weak self] result in
            
            switch result {
            case .success(let value):
               // self?.performActionOnSuccess(value)
                self?.postsAuthToken = value
                self?.storeAuthToken(token: value, username, password)
                completion(.success(value))
            case .failure(let error):
                // self?.performActionOnFailure()
                self?.showAlert()
                completion(.failure(error))
            }
        })
    }
    
    func validateUserCredentials(_ username: String, _ password: String) -> LoginValidation {
        if username.isEmpty || password.isEmpty {
            self.showAlert()
            return .usernamePasswordEmpty
        }
        return .valid
    }
    
    private func showAlert() {
        coordinator?.presentAlert(
            title: LoginConstants.Login.invalidCredentialTitle,
            message: LoginConstants.Login.invalidCredentialMessage
        )
    }
    
    private func storeAuthToken(
        token: String?,
        _ username: String,
        _ password: String
    ) {
        if let token = token {
            print("Token:\(token)")
            print("username:\(username)")
            print("password:\(password)")
            UserDefaultManager.shared.authToken = token
            UserDefaultManager.shared.isLoggedIn = true
            UserDefaultManager.shared.username = username
            UserDefaultManager.shared.userPassword = password
        }
    }
}
