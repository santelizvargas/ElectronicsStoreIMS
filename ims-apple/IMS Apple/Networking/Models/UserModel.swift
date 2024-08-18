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

@Model
final class UserModelPersistence {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let identification: String
    let phone: String
    let address: String
    
    init(id: Int,
         firstName: String,
         lastName: String,
         email: String,
         identification: String, 
         phone: String,
         address: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.identification = identification
        self.phone = phone
        self.address = address
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
    }
}

struct UserModel: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let identification: String
    let phone: String
    let address: String
    let roles: [String]?
    let imageId: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
}

extension UserModel {
    static let mockUsers: [UserModel] = (0...100).map { index in
        UserModel(id: index,
                  firstName: "Name #\(index)",
                  lastName: "Last name #\(index)",
                  email: "email #\(index)",
                  identification: "ID #\(index)",
                  phone: "Phone #\(index)",
                  address: "address #\(index)",
                  roles: ["Rol #\(index)"],
                  imageId: "IMG #\(index)",
                  createdAt: "Date \(index)",
                  updatedAt: "updated #\(index)",
                  deletedAt: "deleted #\(index)")
    }
        
}
