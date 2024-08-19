//
//  UserModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 31/7/24.
//

import Foundation

// TODO: - Remove data mock

struct UserModel: Identifiable {
    var id = UUID()
    let image: String
    let name: String
    let email: String
    let role: [String]
    let date: String
}
