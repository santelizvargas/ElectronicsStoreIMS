//
//  MainViewViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/18/24.
//

import Foundation

final class MainViewViewModel: ObservableObject {
    @Published var logoutSuccess: Bool = false
    
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
}
