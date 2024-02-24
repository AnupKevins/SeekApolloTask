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
    }
}
