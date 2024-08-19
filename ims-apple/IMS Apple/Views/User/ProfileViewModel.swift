//
//  ProfileViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 17/8/24.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var isPasswordEdit: Bool = false
    @Published var userPassword: UserPasswordReset
    @Published var isRequestInProgress: Bool = false
    
    var userInfo: UserInformation {
        UserInformation(user: try? authenticationManager.userLogged())
    }
    
    private let authenticationManager: AuthenticationManager = AuthenticationManager()
    
    private let defaultUserPassword: UserPasswordReset = .init(
        currentPassword: "",
        newPassword: "",
        confirmPassword: ""
    )
    
    init() {
        userPassword = defaultUserPassword
    }
    
    func resetPasswordTextfields() {
        userPassword = defaultUserPassword
    }
    
    func updatePassword() {
        guard userPassword.newPassword == userPassword.confirmPassword else { return }
        isRequestInProgress = true
        
        Task {
            do {
                try await authenticationManager.updatePassword(email: userInfo.email,
                                                               currentPassword: userPassword.currentPassword,
                                                               newPassword: userPassword.newPassword,
                                                               confirmationPassword: userPassword.confirmPassword)
                isPasswordEdit = false
                resetPasswordTextfields()
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
            isRequestInProgress = false
        }
    }
}
