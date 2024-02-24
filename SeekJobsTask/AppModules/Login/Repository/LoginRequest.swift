//
//  RequestService.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation

struct LoginRequest: Requestable {

    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    var baseUrl: URL {
        return URL(string: AppConstants.baseUrls.appBaseUrl)!
    }
}
