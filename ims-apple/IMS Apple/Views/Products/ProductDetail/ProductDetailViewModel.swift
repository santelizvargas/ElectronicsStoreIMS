//
//  ProductDetailViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import Foundation
import SwiftUI

final class ProductDetailViewModel: ObservableObject {
    @Published var isRequestInProgress: Bool = false
    @Published var errorMessage: String?
    @Published var supplyCount: String = ""
    @Binding var reloadProducts: Bool
    
    init(reloadProducts: Binding<Bool>) {
        _reloadProducts = reloadProducts
    }
    
    private let productManager: ProductManager = ProductManager()
    
    func deleteProduct(with id: Int) {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await productManager.deleteProduct(with: id)
                reloadProducts = true
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                errorMessage = error.localizedDescription
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func supplyProduct(id: Int) {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await productManager.supplyProduct(id: id, with: Double(supplyCount) ?? 0)
                reloadProducts = true
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                errorMessage = error.localizedDescription
                debugPrint(error.localizedDescription)
            }
        }
    }
}
