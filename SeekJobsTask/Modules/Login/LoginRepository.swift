//
//  LoginRepositoryLayer.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation
import Apollo
import JobsAPI

protocol LoginRepositoryProtocol {
    func authenticate(username: String, password: String, completion: @escaping (Result<String, AppError>) -> Void)
}

struct LoginRepository: LoginRepositoryProtocol {
    
    func authenticate(username: String, password: String, completion: @escaping (Result<String, AppError>) -> Void) {
        let mutation = AuthMutation(username: username, password: password)
        
        NetworkService.shared.apollo.perform(mutation: mutation) { result in
            
            switch result {
            case .success(let graphQLResult):
                if let authToken = graphQLResult.data?.auth {
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
