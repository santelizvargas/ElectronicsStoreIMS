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
    
    @Published var isReloadUsers: Bool = false {
        didSet {
            guard isReloadUsers else { return }
            getUsers()
            isReloadUsers.toggle()
        }
    }
    
    private let authenticationManager: AuthenticationManager = AuthenticationManager()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                let userList = try await authenticationManager.getUsers()
                users = userList.sorted { $0.createdAt > $1.createdAt }
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
