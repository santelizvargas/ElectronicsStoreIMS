//
//  LoginViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/16/24.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var requestInProgress: Bool = false
    @Published var loginSuccess: Bool = false
    
    private lazy var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    func login(email: String, password: String) {
        requestInProgress = true
        Task {
            do {
                try await authenticationManager.login(email: email, password: password)
                requestInProgress = false
                loginSuccess = true
                // TODO: - Save user using DTO
            } catch {
                requestInProgress = false
                guard let iMSError = error as? IMSError else { return }
                debugPrint(iMSError.localizedDescription)
            }
        }
    }
}
