//
//  RegisterUserViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import Foundation

final class RegisterUserViewModel: ObservableObject {
    @Published var userInfo: UserRegisterModel = .init()
    @Published var isRegistered: Bool = false
    
    private lazy var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    func registerUser() {
        Task { @MainActor in
            do {
                try await authenticationManager.registerUser(user: userInfo)
                userInfo = UserRegisterModel()
                isRegistered = true
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
