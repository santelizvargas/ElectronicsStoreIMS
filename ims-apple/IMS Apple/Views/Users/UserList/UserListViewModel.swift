//
//  UserListViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 20/8/24.
//

import Foundation

final class UserListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var isRequestInProgress: Bool = false
    
    private let authenticationManager: AuthenticationManager = AuthenticationManager()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                users = try await authenticationManager.getUsers()
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
