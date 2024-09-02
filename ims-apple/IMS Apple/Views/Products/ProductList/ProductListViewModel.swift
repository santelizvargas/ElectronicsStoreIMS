//
//  ProductListViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 12/8/24.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    @Published var selectedProduct: ProductModel?
    @Published var products: [ProductModel] = []
    @Published var isRequestInProgress: Bool = false
    
    @Published var selectedState: ProductState = .all {
        didSet { filterProducts() }
    }

    @Published var selectedCategory: ProductCategory = .all {
        didSet { filterProducts() }
    }

    @Published var searchText: String = "" {
        didSet { filterProducts() }
    }
    
    @Published var reloadProducts: Bool = false {
        didSet {
            guard reloadProducts else { return }
            getProducts()
            reloadProducts = false
        }
    }

    private let productManager: ProductManager = ProductManager()
    
    private var allProducts: [ProductModel] = [] {
        didSet { filterProducts() }
    }
    
    init() {
        getProducts()
    }
    
    private func filterProducts() {
        products = allProducts.filter { product in
            let matchesSearch = searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())
            let matchesCategory = selectedCategory == .all || product.category == selectedCategory
            let matchesState = selectedState == .all || (selectedState == .outOfStock ? product.stock == .zero : product.stock > .zero)
            return matchesSearch && matchesCategory && matchesState
        }
        .sorted { $0.createdAt > $1.createdAt }
    }
    
    func getProducts() {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                allProducts = try await productManager.getProducts()
                try await Task.sleep(nanoseconds: 1_000_000_000)
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
