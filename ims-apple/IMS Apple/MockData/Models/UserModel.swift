//
//  UserModel.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 31/7/24.
//

import Foundation

// TODO: - Remove data mock

struct UserModel: Identifiable {
    var id = UUID()
    let image: String
    let name: String
    let email: String
    let role: String
    let date: String
}

extension UserModel {
    static let mockUsers: [UserModel] = [
        UserModel(image: "image1.png", name: "Alice Smith", email: "alice.smith@example.com", role: "Administrador", date: "2024-01-01"),
        UserModel(image: "image2.png", name: "Bob Johnson", email: "bob.johnson@example.com", role: "Usuario", date: "2023-12-15"),
        UserModel(image: "image3.png", name: "Carol Williams", email: "carol.williams@example.com", role: "Moderador", date: "2023-11-30"),
        UserModel(image: "image4.png", name: "David Brown", email: "david.brown@example.com", role: "Administrador", date: "2023-10-25"),
        UserModel(image: "image5.png", name: "Eve Davis", email: "eve.davis@example.com", role: "Usuario", date: "2023-09-10") ]
}
