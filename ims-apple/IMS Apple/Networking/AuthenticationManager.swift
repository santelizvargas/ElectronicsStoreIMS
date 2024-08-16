//
//  UsersManager.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/15/24.
//

import Foundation

final class AuthenticationManager {
    
    private lazy var networkManager: NetworkManager = NetworkManager()
    
    private func saveToken(accessToken: String, email: String) {
        guard let data = accessToken.data(using: .utf8) else { return }
        
        do {
            let response = try KeychainHelper.writeData(data: data, email: email)
            debugPrint(response)
        } catch {
            guard let error = error as? IMSError.Keychain else { return }
            debugPrint(error.description)
        }
    }
    
    func login(email: String, password: String) async throws -> UserEntity {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .login,
                                                            with: parameters,
                                                            httpMethod: .post)
            let response = try JSONDecoder().decode(IMSResponseBody<UserEntity>.self, from: data)
            
            saveToken(accessToken: response.accessToken, email: email)
            
            return response.data
        } catch {
            throw error
        }
    }
    
    func logout() async throws { }
    
}
