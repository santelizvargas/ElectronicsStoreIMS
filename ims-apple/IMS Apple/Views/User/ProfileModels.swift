//
//  ProfileModels.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 18/8/24.
//

import Foundation

struct UserInformation {
    let names: String
    let lastName: String
    let email: String
    let role: UserRole
    
    init(names: String,
         lastName: String,
         email: String,
         role: UserRole) {
        self.names = names
        self.lastName = lastName
        self.email = email
        self.role = role
    }
    
    /// Factory from user model
    init(user: UserModelPersistence?) {
        self.names = user?.firstName ?? ""
        self.lastName = user?.lastName ?? ""
        self.email = user?.email ?? ""
        self.role = UserRole(rawValue: user?.roleId ?? 1) ?? .seller
    }
}

struct UserPasswordReset {
    var currentPassword: String
    var newPassword: String
    var confirmPassword: String
}
