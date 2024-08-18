//
//  UserEntity.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/15/24.
//

import Foundation

struct AuthenticationResponse: Decodable {
    let accessToken: String
    let expiresIn: Int
    let data: UserModel
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
