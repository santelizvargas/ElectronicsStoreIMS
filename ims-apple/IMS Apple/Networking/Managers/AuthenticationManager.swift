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
        guard let user = try fetchUsers().first
        else { throw DataManagerError.fetchModels }
        return user
    }
    
    private func storeUserDTOIfNeeded(user: UserModel) {
        if isAnUserLogged { return }
        let user = UserModelPersistence(user: user)
        dataManager.save(model: user)
    }
    
    private func fetchUsers() throws -> [UserModelPersistence] {
        try dataManager.fetch()
    }
    
    // MARK: - Login
    
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
    
    // MARK: - Logout
    
    func logout() throws {
        let user = try userLogged()
        try dataManager.removeAll()
        debugPrint("--- Logout: \(user.firstName) ---")
    }
    
    // MARK: - Update Password
    
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
            try await networkManager.makeRequest(path: .updatePassword,
                                                 with: parameters,
                                                 httpMethod: .put)
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Register User
    
    func registerUser(user: UserRegisterModel) async throws {
        do {
            let parameters = try await convertToDictionaty(data: user)
            try await networkManager.makeRequest(path: .register,
                                                 with: parameters,
                                                 httpMethod: .post)
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
    
    // MARK: - Convert To Dictionaty
    
    private func convertToDictionaty<T: Codable>(data: T) async throws -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(data)
            let parameters = try JSONSerialization.jsonObject(with: jsonData,
                                                              options: .mutableContainers) as? [String: Any]
            guard let parameters else { throw IMSError.somethingWrong }
            return parameters
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Enable User
    
    func enableUser(id: Int) async throws {
        let parameters: [String: Any] = ["id": id]
        
        do {
            try await networkManager.makeRequest(path: .enableUser,
                                                 with: parameters,
                                                 httpMethod: .put)
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Disable User
    
    func disableUser(id: Int) async throws {
        let parameters: [String: Any] = ["id": id]
        
        do {
            try await networkManager.makeRequest(path: .disableUser,
                                                 with: parameters,
                                                 httpMethod: .delete)
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Assign Roles
    
    func assignRole(role: String, email: String, revoke: Int) async throws {
        let parameters: [String: Any] = [
            "email": email,
            "role": role
        ]
        
        do {
            try await networkManager.makeRequest(path: .roles,
                                                 with: parameters,
                                                 httpMethod: .post)
            try await revokeRole(id: revoke, email: email)
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Revoke Roles
    
    private func revokeRole(id: Int, email: String) async throws {
        let parameters: [String: Any] = [
            "email": email,
            "roleId": id
        ]
        
        do {
            try await networkManager.makeRequest(path: .roles,
                                                 with: parameters,
                                                 httpMethod: .delete)
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Get User Counts
    
    func getUserCounts() async throws -> UsersChartResponse {
        do {
            let data = try await networkManager.makeRequest(path: .usersChart)
            let response = try JSONDecoder().decode(UsersChartResponse.self, from: data)
            return response
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
