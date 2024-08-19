//
//  UsersManager.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/15/24.
//

import Foundation

final class AuthenticationManager {
    
    var isAnUserLogged: Bool {
        do {
            try userLogged()
            return true
        } catch {
            return false
        }
    }
    
    private var networkManager: NetworkManager = NetworkManager()
    private var dataManager: DataManager = DataManager<UserModelPersistence>()
    
    @discardableResult
    private func userLogged() throws -> UserModelPersistence {
        guard let user = try fetchTest().first
        else { throw DataManagerError.fetchModels }
        return user
    }
    
    private func storeUserDTO(user: UserModel) {
        let user = UserModelPersistence(user: user)
        dataManager.save(model: user)
    }
    
    private func fetchTest() throws -> [UserModelPersistence] {
        try dataManager.fetch()
    }
    
    @discardableResult
    func login(email: String, password: String) async throws -> UserModel {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .login,
                                                            with: parameters,
                                                            httpMethod: .post)
            let response = try JSONDecoder().decode(AuthenticationResponse.self, from: data)
            storeUserDTO(user: response.data)
            debugPrint("\(email) login successfully!")
            return response.data
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    func logout() throws {
        let user = try userLogged()
        try dataManager.removeAll()
        debugPrint("--- Logout: \(user.firstName) ---")
    }
}
