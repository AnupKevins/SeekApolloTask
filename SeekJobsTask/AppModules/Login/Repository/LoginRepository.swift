//
//  LoginRepositoryLayer.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import JobsAPI

protocol LoginRepositoryProtocol {
    func authenticate(loginRequest: LoginRequest, completion: @escaping (Result<String, AppError>) -> Void)
}

struct LoginRepository: LoginRepositoryProtocol {
    
    func authenticate(loginRequest: LoginRequest, completion: @escaping (Result<String, AppError>) -> Void) {
        let mutation = AuthMutation(
            username: loginRequest.username, password: loginRequest.password
        )
        //let networkService = NetworkService(request: loginRequest)
        let networkService = NetworkService.shared
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

