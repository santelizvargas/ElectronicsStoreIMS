//
//  ProfileViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 17/8/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var isPasswordEdit: Bool = false
    @Published var userPassword: UserPasswordReset
    @Published var isRequestInProgress: Bool = false
    
    var userInfo: UserInformation {
        UserInformation(user: try? authenticationManager.userLogged())
    }
    
    var shortName: String {
        let names = userInfo.names.components(separatedBy: " ")
        let lastName = userInfo.lastName.components(separatedBy: " ")
        return "\(names.first ?? "") \(lastName.first ?? "")"
    }
    
    var isSavePasswordDisabled: Bool {
        userPassword.currentPassword.isEmpty ||
        userPassword.newPassword.isEmpty ||
        userPassword.confirmPassword.isEmpty
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
    
    func updatePasswordIfNeeded() {
        guard userPassword.newPassword == userPassword.confirmPassword else { return }
        isRequestInProgress = true
        
        Task { @MainActor in
            do {
                try await authenticationManager.updatePassword(email: userInfo.email,
                                                               currentPassword: userPassword.currentPassword,
                                                               newPassword: userPassword.newPassword,
                                                               confirmPassword: userPassword.confirmPassword)
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
