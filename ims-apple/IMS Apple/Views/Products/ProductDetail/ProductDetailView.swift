//
//  ProductDetailView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 21/8/24.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.dismiss) private var dismiss
    private let product: ProductModel
    
    init(product: ProductModel) {
        self.product = product
    }
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 6)
                .fill(.secondaryBackground)
                .overlay {
                    AsyncImage(url: URL(string: "url")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                    } placeholder: {
                        Image(systemName: "moon.stars.fill")
                    }
                }
                .frame(width: 180, height: 220)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(product.name)
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
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
                        
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Eliminar")
                        }
                        .foregroundStyle(.red)
                    }
                    .frame(maxWidth: .infinity, minHeight: 35)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red)
                    }
                    .buttonStyle(.plain)
                    
                    Button("Abastecer") {
                        
                    }
                    .buttonStyle(
                        GradientButtonStyle(
                            imageLeft: "repeat",
                            buttonWidth: .infinity,
                            buttonHeight: 35
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(30)
        .frame(width: 650, height: 310)
        .foregroundStyle(.imsWhite)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.grayBackground)
        }
    }
    
    private func banner(text: String) -> some View {
        Text(text)
            .bold()
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.secondaryBackground)
            }
    }
}