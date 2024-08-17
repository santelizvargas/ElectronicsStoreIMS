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
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .login,
                                                            with: parameters,
                                                            httpMethod: .post)
            guard let response = try? JSONDecoder().decode(IMSResponse<UserEntity>.self, from: data)
            else { throw IMSError.somethingWrong }
            debugPrint("\(email) login successfully!")
            return response.data
        } catch {
            throw error
        }
    }
    
    func logout() async throws { }
    
}
