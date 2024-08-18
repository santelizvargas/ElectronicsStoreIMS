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
    let data: UserEntity
}

struct UserEntity: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let identification: String
    let phone: String
    let address: String
    
    // TODO: - Fill when user model has been finished
    
//    let roles: [String]?
//    let imageId: String?
//    let updatedAt: String
//    let deletedAt: String
}
