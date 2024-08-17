//
//  UserEntity.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/15/24.
//

import Foundation

struct UserEntity: Codable {
    let id: Int
    let firstName: String
    let email: String
    let roles: String?
    let identification: String
    let phone: String
    let address: String
    var imageId: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""
    var deletedAt: String = ""
}
