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
    func userLogged() throws -> UserModelPersistence {
        guard let user = try fetchTest().first
        else { throw DataManagerError.fetchModels }
        return user
    }
    
    private func storeUserDTOIfNeeded(user: UserModel) {
        if isAnUserLogged { return }
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
            storeUserDTOIfNeeded(user: response.data)
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
    
    func updatePassword(email: String,
                        currentPassword: String,
                        newPassword: String,
                        confirmPassword: String) async throws {
        if currentPassword == newPassword {
            throw IMSError.sameAsLastPassword
        }
        
        let parameters: [String: Any] = [
            "email": email,
            "currentPassword": currentPassword,
            "password": newPassword,
            "confirmPassword": confirmPassword
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .updatePassword,
                                                            with: parameters,
                                                            httpMethod: .put)
            let response = try JSONDecoder().decode(UpdatePasswordResponse.self, from: data)
            debugPrint("---\(response.message) by \(response.data.firstName)---")
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Fetch All Users
    
    func getUsers() async throws -> [UserModel] {
        do {
            let data = try await networkManager.makeRequest(path: .users)
            let response = try JSONDecoder().decode(UserResponse.self, from: data)
            return response.data
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
