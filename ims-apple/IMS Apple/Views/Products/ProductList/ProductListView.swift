//
//  ProductListView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 11/8/24.
//

import SwiftUI

private enum Constants {
    static let gridMinimum: CGFloat = 200
    static let padding: CGFloat = 10
    static let cardWidth: CGFloat = 210
    static let cardHeight: CGFloat = 255
    static let cornerRadius: CGFloat = 8
    static let lineLimit: Int = 2
    
    enum Image {
        static let padding: CGFloat = 5
        static let cornerRadius: CGFloat = 6
        static let height: CGFloat = 140
    }
    
    enum Banner {
        static let width: CGFloat = 80
        static let height: CGFloat = 25
    }
}

// MARK: - Product List View

struct ProductListView: View {
    @ObservedObject private var viewModel: ProductListViewModel = .init()
    private let adaptiveColumn = [GridItem(.adaptive(minimum: Constants.gridMinimum), spacing: Constants.padding)]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: adaptiveColumn, spacing: Constants.padding) {
                ForEach(viewModel.products) { product in
                    productCard(product)
                        .animation(.easeInOut, value: viewModel.products)
                }
            }
            .padding()
        }
        .background(.grayBackground)
        .searchable(text: $viewModel.searchText)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) { stateMenu }
            ToolbarItem(placement: .destructiveAction) { categoryMenu }
        }
        .refreshable {
            viewModel.getProducts()
        }
        .overlay {
            if viewModel.products.isEmpty {
                CustomProgressView()
            }
        }
    }
    
    // MARK: - State Menu View
    
    private var stateMenu: some View {
        Menu(viewModel.selectedState.title) {
            ForEach(ProductState.allCases, id: \.self) { status in
                Button(status.title) {
                    withAnimation {
                        viewModel.selectedState = status
                    }
                }
            }
        }
    }
    
    // MARK: - Category Menu View
    
    private var categoryMenu: some View {
        Menu(viewModel.selectedCategory.title) {
            ForEach(ProductCategory.allCases, id: \.self) { category in
                Button(category.title) {
                    withAnimation {
                        viewModel.selectedCategory = category
                    }
                }
            }
        }
    }
    
    // MARK: - Product Card View
    
    private func productCard(_ product: ProductModel) -> some View {
        VStack(alignment: .leading, spacing: Constants.cornerRadius) {
            productImage(url: "product.image")
            
            Text(product.name)
                .bold()
            
            Text(product.description)
                .foregroundStyle(.graySecundary)
                .lineLimit(Constants.lineLimit)
            
            Text("$ \(product.salePrice)")
                .bold()
            
            Spacer()
        }
        .padding([.top, .horizontal], Constants.padding)
        .frame(maxWidth: .infinity, maxHeight: Constants.cardHeight)
        .background(.secondaryBackground)
        .overlay(alignment: .topTrailing) {
            amountBanner(amount: product.stock)
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
    
    // MARK: - Amount Banner
    
    @ViewBuilder
    private func amountBanner(amount: Int) -> some View {
        let isInStock: Bool = amount > .zero
        let gradient = LeftGradient(colors: isInStock ? [.purpleGradient, .blueGradient] : [.red, .orange])
        
        Text(isInStock ? "\(amount) pcs" : "Agotado")
            .bold()
            .frame(
                width: Constants.Banner.width,
                height: Constants.Banner.height
            )
            .background(gradient)
    }
    
    // MARK: - Product Image View
    
    private func productImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            RoundedRectangle(cornerRadius: Constants.Image.cornerRadius)
                .fill(.white)
                .overlay {
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(Constants.Image.padding)
                }
        } placeholder: {
            Image(systemName: "moon.stars.fill")
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.Image.height)
    }
}

#Preview {
    ProductListView()
        .frame(minWidth: 800, minHeight: 500)
}
