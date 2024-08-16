//
//  ProductListViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 12/8/24.
//

import Foundation

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

    private let allProducts: [ProductModel]

    init() {
        allProducts = ProductModel.products
        products = allProducts
    }
    
    private func filterProducts() {
        products = allProducts.filter { product in
            let matchesSearch = searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())
            let matchesCategory = selectedCategory == .all || product.category == selectedCategory
            let matchesState = selectedState == .all || (selectedState == .outOfStock ? product.amount == .zero : product.amount > .zero)
            return matchesSearch && matchesCategory && matchesState
        }
    }
}
