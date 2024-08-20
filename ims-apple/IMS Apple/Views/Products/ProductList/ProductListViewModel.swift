//
//  ProductListViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 12/8/24.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    
    @Published var selectedState: ProductState = .all {
        didSet { filterProducts() }
    }

    @Published var selectedCategory: ProductCategory = .all {
        didSet { filterProducts() }
    }

    @Published var searchText: String = "" {
        didSet { filterProducts() }
    }

    private let productManager: ProductManager = ProductManager()
    
    private var allProducts: [ProductModel] = []
    private var isRequestInProgress: Bool = false
    
    private func filterProducts() {
        products = allProducts.filter { product in
            let matchesSearch = searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())
            let matchesCategory = selectedCategory == .all || product.category == selectedCategory
            let matchesState = selectedState == .all || (selectedState == .outOfStock ? product.stock == .zero : product.stock > .zero)
            return matchesSearch && matchesCategory && matchesState
        }
    }
    
    func getProducts() {
        isRequestInProgress = false
        Task {
            do {
                allProducts = try await productManager.getProducts()
                products = allProducts
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
