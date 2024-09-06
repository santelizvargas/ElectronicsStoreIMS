//
//  BackupManager.swift
//  IMS Apple
//
//  Created by Derian Córdoba on 5/9/24.
//

import Foundation

// MARK: - Backup manager class

final class DatabaseManager {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManager = NetworkManager()
    
    @discardableResult
    func backup() async throws -> DatabaseResponseModel {
        do {
            let data = try await networkManager.makeRequest(path: .backupDatabase,
                                                            httpMethod: .post)
            let response = try JSONDecoder().decode(DatabaseResponseModel.self, from: data)
            debugPrint("Backup created successfully!")
            return response
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    @discardableResult
    func restore(backup name: String) async throws -> DatabaseResponseModel {
        let parameters: [String: Any] = [
            "backupName": name,
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .restoreDatabase,
                                                            with: parameters,
                                                            httpMethod: .post)
            let response = try JSONDecoder().decode(DatabaseResponseModel.self, from: data)
            debugPrint("Backup restored successfully!")
            return response
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    func list() async throws -> [String] {
        do {
            let data = try await networkManager.makeRequest(path: .listDatabase,
                                                            httpMethod: .get)
            let response = try JSONDecoder().decode(ListDatabaseResponseModel.self, from: data)
            debugPrint("Backup list fetched successfully!")
            return response.data
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
