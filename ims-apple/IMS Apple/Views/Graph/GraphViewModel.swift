//
//  GraphViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 20/8/24.
//

import Foundation

final class GraphViewModel: ObservableObject {
    @Published var productCount: Int = .zero
    @Published var enabledUserCount: Int = .zero
    @Published var disabledUserCount: Int = .zero
    
    private lazy var productManager: ProductManager = ProductManager()
    private lazy var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    init() {
        getProductCount()
        getUserCount()
    }
    
    func getProductCount() {
        Task { @MainActor in
            do {
                productCount = try await productManager.getProductCount()
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getUserCount() {
        Task { @MainActor in
            do {
                let response = try await authenticationManager.getUserCounts()
                enabledUserCount = response.usersCount
                disabledUserCount = response.suspendedCount
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
