//
//  LoginViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/16/24.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var requestInProgress: Bool = false
    @Published var loginSuccess: Bool = false
    @Published var isShowLaunchScreen: Bool = true
    @Published var isLoginError: Bool = false
    
    private var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    func login(email: String, password: String) {
        requestInProgress = true
        Task { @MainActor in
            do {
                try await authenticationManager.login(email: email, password: password)
                requestInProgress = false
                loginSuccess = authenticationManager.isAnUserLogged
            } catch {
                requestInProgress = false
                isLoginError = true
                guard let iMSError = error as? IMSError else { return }
                debugPrint(iMSError.localizedDescription)
            }
        }
    }
    
    func checkIsUserLogged() {
        loginSuccess = false
        isShowLaunchScreen = true
        Task { @MainActor in
            try await Task.sleep(for: .seconds(2))
            loginSuccess = authenticationManager.isAnUserLogged
            try await Task.sleep(for: .seconds(1))
            isShowLaunchScreen = false
        }
    }
}
