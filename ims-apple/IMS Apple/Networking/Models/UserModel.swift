//
//  UserEntity.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/15/24.
//

import Foundation
import SwiftData

struct AuthenticationResponse: Decodable {
    let accessToken: String
    let expiresIn: Int
    let data: UserModel
}

struct UserResponse: Decodable {
    let data: [UserModel]
}

struct UserAuthResponse: Decodable {
    let message: String
    let code: Int
}

struct UpdatePasswordResponse: Decodable {
    let message: String
    let code: Int
    let data: UserModel
}

@Model
final class UserModelPersistence {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let identification: String
    let phone: String
    let address: String
    let roleId: Int?
    
    init(id: Int,
         firstName: String,
         lastName: String,
         email: String,
         identification: String, 
         phone: String,
         address: String,
         roleId: Int?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.identification = identification
        self.phone = phone
        self.address = address
        self.roleId = roleId
    }
    
    /// Factory from user model entity
    init(user: UserModel) {
        self.id = user.id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
        self.identification = user.identification
        self.phone = user.phone
        self.address = user.address
        
        if let first = user.roles.first,
           let role = UserRole(rawValue: first.id) {
            self.roleId = role.id
        }
    }
}

struct UserModel: Decodable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let identification: String
    let phone: String
    let address: String
    let roles: [RoleModel]
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}

struct RoleModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let createdAt: String?
    let udpatedAt: String?
    let deletedAt: String?
}
