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
                requestInProgressPublished = false
                // TODO: - Save user using DTO
            } catch {
                requestInProgressPublished = false
                guard let iMSError = error as? IMSError else { return }
                debugPrint(iMSError.localizedDescription)
            }
        }
    }
}
