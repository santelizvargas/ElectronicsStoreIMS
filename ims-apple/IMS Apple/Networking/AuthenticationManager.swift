//
//  UsersManager.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/15/24.
//

import Foundation

final class AuthenticationManager {
    
    private lazy var networkManager: NetworkManager = NetworkManager()
    
    func login(email: String, password: String) async throws -> UserEntity {
        let path: IMSPath = .login
        let parameters: [String: Any] = [
            "email": "derianricardo451@gmail.com",
            "password": "password2"
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: path,
                                                            with: parameters,
                                                            httpMethod: .post)
            let user = try JSONDecoder().decode(UserEntity.self, from: data)
            return user
        } catch {
            throw error
        }
    }
    
    func logout() async throws { }
    
}
