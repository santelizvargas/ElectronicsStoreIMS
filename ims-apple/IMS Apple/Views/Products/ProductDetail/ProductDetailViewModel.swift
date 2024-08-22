//
//  ProductDetailViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    
    @Published var isRequestInProgress: Bool = false
    @Published var errorMessage: String?
    
    private let productManager: ProductManager = ProductManager()
    
    func deleteProduct(with id: Int) {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await productManager.deleteProduct(with: id)
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                errorMessage = error.localizedDescription
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func supplyProduct(id: Int, stock: Double) {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await productManager.supplyProduct(id: id, with: stock)
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                errorMessage = error.localizedDescription
                debugPrint(error.localizedDescription)
            }
        }
    }
}
