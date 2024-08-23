//
//  ProductDetailView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 21/8/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 20
    static let cornerRadius: CGFloat = 10
    static let smallPadding: CGFloat = 5
    static let middlePadding: CGFloat = 8
    static let bigPadding: CGFloat = 30
    static let imageWidth: CGFloat = 180
    static let imageHeight: CGFloat = 220
    static let editSize: CGFloat = 25
    static let bannerSize: CGFloat = 50
    static let trashHeight: CGFloat = 36
    static let cardWidth: CGFloat = 650
    static let cardHeight: CGFloat = 310
}

struct ProductDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ProductDetailViewModel
    private let product: ProductModel
    
    init(product: ProductModel, 
         reloadProducts: Binding<Bool>) {
        self.product = product
        self.viewModel = ProductDetailViewModel(reloadProducts: reloadProducts)
    }
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.secondaryBackground)
                .overlay {
                    AsyncImage(url: URL(string: "url")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(Constants.smallPadding)
                    } placeholder: {
                        Image(systemName: "moon.stars.fill")
                    }
                }
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(product.name)
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(.editIcon)
                            .resizable()
                            .frame(width: Constants.editSize, height: Constants.editSize)
                    }
                    .buttonStyle(.plain)
                }
                
                HStack {
                    banner(text: product.category.title)
                    banner(text: "\(product.stock) pcs")
                    Spacer()
                }
                
                Text(product.description ?? "")
                    .padding(.vertical)
                
                Spacer()
                
                HStack {
                    Button {
                        viewModel.deleteProduct(with: product.id)
                        if viewModel.errorMessage == nil {
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Eliminar")
                        }
                        .foregroundStyle(.red)
                    }
                    .frame(maxWidth: .infinity, minHeight: Constants.trashHeight)
                    .background {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(.red)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    
                    Button("Abastecer") {
                        viewModel.supplyProduct(id: product.id, stock: 1)
                        if viewModel.errorMessage == nil {
                            dismiss()
                        }
                    }
                    .buttonStyle(
                        GradientButtonStyle(
                            imageLeft: "repeat",
                            buttonWidth: .infinity,
                            buttonHeight: Constants.trashHeight
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
                if viewModel.isRequestInProgress {
                    ProgressView()
                        .controlSize(.extraLarge)
                }
            }
        }
        .padding(Constants.bigPadding)
        .frame(width: Constants.cardWidth, height: Constants.cardHeight)
        .foregroundStyle(.imsWhite)
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.grayBackground)
        }
    }
    
    private func banner(text: String) -> some View {
        Text(text)
            .bold()
            .padding(.horizontal)
            .padding(.vertical, Constants.middlePadding)
            .background {
                RoundedRectangle(cornerRadius: Constants.bannerSize)
                    .fill(.secondaryBackground)
            }
    }
}
