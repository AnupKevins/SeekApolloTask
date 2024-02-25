//
//  UserDefaultsManager.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation

class UserDefaultManager {
   
    static let shared = UserDefaultManager()

    private enum Keys {
        static let authToken = "userAuthToken"
        static let isLoggedIn = "isLoggedIn"
        static let userName = "userName"
        static let userPassword = "userPassword"
    }

    private let userDefaults = UserDefaults.standard

    var authToken: String? {
        get {
            return userDefaults.string(forKey: Keys.authToken)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.authToken)
        }
    }
    
    var username: String? {
        get {
            return userDefaults.string(forKey: Keys.userName)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.userName)
        }
    }
    
    var userPassword: String? {
        get {
            return userDefaults.string(forKey: Keys.userPassword)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.userPassword)
        }
    }

    var isLoggedIn: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isLoggedIn)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isLoggedIn)
        }
    }

    func clearUserData() {
        userDefaults.removeObject(forKey: Keys.authToken)
        userDefaults.removeObject(forKey: Keys.isLoggedIn)
        userDefaults.removeObject(forKey: Keys.userName)
        userDefaults.removeObject(forKey: Keys.userPassword)
    }
}
