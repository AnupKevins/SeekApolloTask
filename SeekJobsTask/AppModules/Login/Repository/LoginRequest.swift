//
//  RequestService.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation

struct LoginRequest {

    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
