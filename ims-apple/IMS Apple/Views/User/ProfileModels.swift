//
//  ProfileModels.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 18/8/24.
//

import Foundation

struct UserInformation {
    let names: String
    let lastName: String
    let email: String
    
    init(names: String, lastName: String, email: String) {
        self.names = names
        self.lastName = lastName
        self.email = email
    }
    
    /// Factory from user model
    init(user: UserModelPersistence?) {
        self.names = user?.firstName ?? ""
        self.lastName = user?.lastName ?? ""
        self.email = user?.email ?? ""
    }
}

struct UserPasswordReset {
    var currentPassword: String
    var newPassword: String
    var confirmPassword: String
}
