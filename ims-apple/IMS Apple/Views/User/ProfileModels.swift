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
}

struct UserPasswordReset {
    var currentPassword: String
    var newPassword: String
    var confirmPassword: String
}
