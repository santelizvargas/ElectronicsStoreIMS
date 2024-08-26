//
//  MainViewViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/18/24.
//

import Foundation

final class MainViewViewModel: ObservableObject {
    @Published var logoutSuccess: Bool = false
    @Published var userLogged: UserModelPersistence?
    
    private var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    func logout() {
        do {
            try authenticationManager.logout()
            logoutSuccess = true
        } catch {
            guard let error = error as? DataManagerError else { return }
            debugPrint(error.description)
        }
    }
    
    func getUserLogged() {
        do {
            userLogged = try authenticationManager.userLogged()
        } catch {
            guard let error = error as? DataManagerError else { return }
            debugPrint(error.description)
        }
    }
}
