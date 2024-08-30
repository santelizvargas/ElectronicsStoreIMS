//
//  UserRegisterModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import Foundation

struct UserRegisterModel: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var identification: String = ""
    var phone: String = ""
    var address: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    func someFieldsAreEmpty() -> Bool {
        firstName.isEmpty ||
        lastName.isEmpty ||
        identification.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty
    }
}
