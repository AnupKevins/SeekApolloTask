//
//  LoginRepositoryLayer.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import JobsAPI

protocol LoginRepositoryProtocol {
    var networkService : NetworkService { get set }
    
    func authenticate(loginRequest: LoginRequest, completion: @escaping (Result<String, AppError>) -> Void)
}

struct LoginRepository: LoginRepositoryProtocol {
    
   var networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func authenticate(loginRequest: LoginRequest, completion: @escaping (Result<String, AppError>) -> Void) {
        let mutation = AuthMutation(
            username: loginRequest.username, password: loginRequest.password
        )
        
        networkService.performMutationWithGraphQLQuery(mutation: mutation) { result in
            
            switch result {
            case .success(let graphQLResultData):
                if let authToken = graphQLResultData?.auth as? String {
                    completion(.success(authToken))
                } else {
                    let appError = AppError.dataError(
                        description: "Invalid Response"
                    )
                    completion(.failure(appError))
                }
            case .failure(let error):
                // Handle network or other errors
                let appError = AppError.dataError(
                    description: error.localizedDescription
                )
                
                completion(.failure(appError))
            }
        }
    }
}

