//
//  ProductCodeView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 24/8/24.
//

import SwiftUI

private enum Constants {
    static let gridItemSize: CGFloat = 200
    static let gridSpacing: CGFloat = 20
    static let cardSpacing: CGFloat = 10
    static let viewSize: CGFloat = 700
    static let textfieldWidth: CGFloat = 200
    static let textfieldHeight: CGFloat = 30
}

// MARK: - Product Code View

struct ProductCodeView: View {
    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss
    
    private let products: [ProductModel]
    
    private let adaptiveColumn = [GridItem(
        .adaptive(minimum: Constants.gridItemSize),
        spacing: Constants.gridSpacing
    )]
    
    init(products: [ProductModel]) {
        self.products = products
    }
    
    var body: some View {
        NavigationStack {
            if OSType.current == .macOS { searchBar }
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: adaptiveColumn, spacing: Constants.gridSpacing) {
                    ForEach(filterProducts) { product in
                        productCard(for: product)
                    }
                }
            }
            .padding()
            .isOS(.iOS) { view in
                view.searchable(text: $searchText)
                    .background(.grayBackground)
            }
        }
        .frame(width: Constants.viewSize)
        .isOS(.macOS) { $0.frame(height: Constants.viewSize) }
    }
    
    // MARK: - Row View
    
    private func getRow(name: String, value: String) -> some View {
        Text(name)
            .bold()
        +
        Text(value)
            .foregroundStyle(.imsGraySecundary)
    }
    
    // MARK: - Search Bar
    
    private var searchBar: some View {
        HStack {
            Spacer()
            
            TextField("Search", text: $searchText)
                .textFieldStyle(.plain)
                .frame(width: Constants.textfieldWidth, height: Constants.textfieldHeight)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.cardSpacing)
                        .stroke(.imsGraySecundary)
                }
        }
        .padding(Constants.cardSpacing)
    }
    
    // MARK: - List Card
    
    private func productCard(for product: ProductModel) -> some View {
        VStack(alignment: .leading, spacing: Constants.cardSpacing) {
            getRow(name: "Codigo: ", value: product.id.description)
            getRow(name: "Nombre: ", value: product.name)
            getRow(name: "Description: ", value: product.description)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: Constants.textfieldWidth)
        .foregroundStyle(.white)
        .background {
            RoundedRectangle(cornerRadius: Constants.cardSpacing)
                .fill(.secondaryBackground)
        }
        .animation(.easeInOut, value: filterProducts)
    }
    
    // MARK: - Filter products
    
    private var filterProducts: [ProductModel] {
        searchText.isEmpty
        ? products
        : products.filter { product in
            product.name.lowercased().contains(searchText.lowercased()) ||
            product.description.lowercased().contains(searchText.lowercased())
        }
    }
}

