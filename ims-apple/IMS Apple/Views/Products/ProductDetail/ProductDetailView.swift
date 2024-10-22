//
//  ProductDetailView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 21/8/24.
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
    static let closeSize: CGFloat = 15
    static let bannerSize: CGFloat = 50
    static let trashHeight: CGFloat = 36
    static let cardWidth: CGFloat = 650
    static let cardHeight: CGFloat = 310
}

struct ProductDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ProductDetailViewModel
    @State private var isSupplyActive: Bool = false
    private let product: ProductModel
    
    init(product: ProductModel, 
         reloadProducts: Binding<Bool>) {
        self.product = product
        self.viewModel = ProductDetailViewModel(reloadProducts: reloadProducts)
    }
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            productImage
            
            VStack(alignment: .leading) {
                headerView
                
                HStack {
                    banner(text: product.category.rawValue)
                    banner(text: "\(product.stock) pcs")
                    Spacer()
                }
                
                Text(product.description)
                    .padding(.vertical)
                
                Spacer()
                
                if isSupplyActive {
                    supplyView
                } else {
                    bottomButtons
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
    
    // MARK: - Banner View
    
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
    
    // MARK: Product Image View
    
    private var productImage: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(.imsWhite)
            .overlay {
                AsyncImage(url: URL(string: product.images.first ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(Constants.smallPadding)
                } placeholder: {
                    Image(systemName: "moon.stars.fill")
                }
            }
            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Text(product.name)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: Constants.closeSize, height: Constants.closeSize)
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
        }
    }
    
    // MARK: - Bottom Buttons
    
    private var bottomButtons: some View {
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
                isSupplyActive.toggle()
            }
            .buttonStyle(
                GradientButtonStyle(
                    imageLeft: "repeat",
                    buttonWidth: .infinity,
                    buttonHeight: Constants.trashHeight
                )
            )
        }
        .padding(.bottom)
    }
    
    // MARK: - Supply TextField view
    
    private var supplyView: some View {
        HStack {
            IMSTextField(
                text: $viewModel.supplyCount.allowOnlyNumbers,
                placeholder: "Cantidad extra",
                hasBorder: true,
                minHeight: Constants.trashHeight
            )
            
            Button {
                viewModel.supplyProduct(id: product.id)
                
                if viewModel.errorMessage == nil {
                    dismiss()
                }
            } label: {
                Image(systemName: "repeat")
            }
            .buttonStyle(
                GradientButtonStyle(
                    buttonWidth: 40,
                    buttonHeight: Constants.trashHeight
                )
            )
            .disabled(viewModel.supplyCount.isEmpty)
            .opacity(viewModel.supplyCount.isEmpty ? 0.6 : 1)
            
            Button {
                isSupplyActive.toggle()
            } label: {
                Image(systemName: "xmark")
                    .contentShape(Rectangle())
            }
            .buttonStyle(
                GradientButtonStyle(
                    buttonWidth: 40,
                    buttonHeight: Constants.trashHeight,
                    gradientColors: [.redGradient, .orangeGradient]
                )
            )
        }
    }
}
