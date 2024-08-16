//
//  UserEntity.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/15/24.
//

import Foundation

struct UserEntity: Decodable {
//    var uuid = UUID()
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    var roles: String = "Admin"
    let identification: String
    let phone: String
    let address: String
    let imageId: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
}
