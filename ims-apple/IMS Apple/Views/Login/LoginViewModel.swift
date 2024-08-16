//
//  LoginViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/16/24.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    
    
    @Published private var requestInProgressPublished: Bool = false {
        didSet {
            requestInProgress = requestInProgressPublished
        }
    }
    
    var requestInProgress: Bool = false
    
    private lazy var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    func login(email: String, password: String) {
        requestInProgressPublished = true
        Task {
            try await Task.sleep(for: .seconds(2))
            do {
                let user = try await authenticationManager.login(email: email, password: password)
                print(user.firstName)
                // TODO: - Save user using DTO
            } catch {
                guard let imsError = error as? IMSError else { return }
                print(imsError.description)
            }
            requestInProgressPublished = false
        }
    }
}
