//
//  LoginConstants.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import Foundation

enum LoginConstants {
    
    enum Login {
        static let userNamePlaceholder = "Username"
        static let passwordPlaceholder = "Password"
        static let loginPlaceholder = "Login"
        static let invalidCredentialTitle = "Invalid Credential"
        static let invalidCredentialMessage = "Enter a valid UserName and Password"
    }
}

enum LoginValidation {
    case usernamePasswordEmpty
    case valid
}
