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
    
    let userInfo: UserInformation = .init(
        names: "Juan",
        lastName: "Perez",
        email: "test@gmail.com"
    )
    
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
}
