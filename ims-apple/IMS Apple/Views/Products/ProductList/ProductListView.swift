//
//  ProductListView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 11/8/24.
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
    @State private var isPresented: Bool = false
    
    private let adaptiveColumn = [GridItem(.adaptive(minimum: Constants.gridMinimum), spacing: Constants.padding)]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: adaptiveColumn, spacing: Constants.padding) {
                ForEach(viewModel.products) { product in
                    Button {
                        withAnimation {
                            viewModel.selectedProduct = product
                            isPresented = true
                        }
                    } label: {
                        productCard(product)
                    }
                    .buttonStyle(.plain)
                    .animation(.easeInOut, value: viewModel.products)
                }
            }
            .padding()
        }
        .isOS(.iOS) { view in
            view.popover(isPresented: $isPresented) {
                if let selectedProduct = viewModel.selectedProduct {
                    ProductDetailView(product: selectedProduct, reloadProducts: $viewModel.reloadProducts)
                        .presentationCompactAdaptation(.popover)
                }
            }
        }
        .isOS(.macOS) { view in
            view.sheet(isPresented: $isPresented) {
                if let selectedProduct = viewModel.selectedProduct {
                    ProductDetailView(product: selectedProduct, reloadProducts: $viewModel.reloadProducts)
                }
            }
        }
        .background(.grayBackground)
        .searchable(text: $viewModel.searchText)
        .toolbar {
            if OSType.current == .macOS {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: viewModel.getProducts) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.imsWhite)
                    }
                }
            }
            
            ToolbarItem(placement: .destructiveAction) {
                ExporterNav(fileName: "Lista de productos", collection: viewModel.products)
            }
            
            ToolbarItem(placement: .destructiveAction) { stateMenu }
            ToolbarItem(placement: .destructiveAction) { categoryMenu }
        }
        .refreshable {
            viewModel.getProducts()
        }
        .overlay {
            if viewModel.isRequestInProgress {
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
        .foregroundStyle(.imsWhite)
    }
    
    // MARK: - Category Menu View
    
    private var categoryMenu: some View {
        Menu(viewModel.selectedCategory.rawValue) {
            ForEach(ProductCategory.allCases, id: \.self) { category in
                Button(category.rawValue) {
                    withAnimation {
                        viewModel.selectedCategory = category
                    }
                }
            }
        }
        .foregroundStyle(.imsWhite)
    }
    
    // MARK: - Product Card View
    
    private func productCard(_ product: ProductModel) -> some View {
        VStack(alignment: .leading, spacing: Constants.cornerRadius) {
            productImage(url: product.images.first ?? "")
            
            Text(product.name)
                .bold()
            
            Text(product.description)
                .foregroundStyle(.graySecundary)
                .lineLimit(Constants.lineLimit)
            
            HStack {
                Text("$ \(product.salePrice.description)")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("cod: \(product.id)")
            }
            
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
