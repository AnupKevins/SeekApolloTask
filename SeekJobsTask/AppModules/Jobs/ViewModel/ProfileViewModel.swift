//
//  ProfileViewModel.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 25/02/24.
//

import Foundation

protocol ProfileViewModelProtocol {
    
    var userDefaultManager: UserDefaultManager { get set }
    
    func getUserName() -> String
    func getPassword() -> String
    func onLogout()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var userDefaultManager: UserDefaultManager
    
    init(userDefaultManager: UserDefaultManager = UserDefaultManager.shared) {
        self.userDefaultManager = userDefaultManager
    }
    
    func getUserName() -> String {
        return self.userDefaultManager.username ?? ""
    }
    
    func getPassword() -> String {
        return self.userDefaultManager.userPassword ?? ""
    }
    
    func onLogout() {
        self.userDefaultManager.clearUserData()
    }
}
