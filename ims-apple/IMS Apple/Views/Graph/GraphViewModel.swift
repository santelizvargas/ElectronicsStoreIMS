//
//  GraphViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 20/8/24.
//

import Foundation

final class GraphViewModel: ObservableObject {
    @Published var productCount: Int = .zero
    
    private lazy var productManager: ProductManager = ProductManager()
    
    init() {
       getProductCount()
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
}
