//
//  AddProductView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 13/8/24.
//

import SwiftUI
import PhotosUI

private enum Constants {
    static let buttonHeight: CGFloat = 40
    static let horizontalSpacing: CGFloat = 20
    static let hasBorder: Bool = true
    static let minHeight: CGFloat = 30
    static let cornerRadiusSize: CGFloat = 8
    static let photoMaxHeight: CGFloat = 120
    static let detailButtonHeight: CGFloat = 70
    static let strokLengths: CGFloat = 10
    static let spaceSize: CGFloat = 10
    static let loadingImage: String = "square.and.arrow.down"
    static let saveProductImage: String = "square.and.arrow.down.on.square.fill"
}

struct AddProductView: View {
    @State private var productName: String = ""
    @State private var price: String = ""
    @State private var availableUnits: String = ""
    @State private var productDetails: String = ""
    @State private var state: String = ""
    @State private var selectedState: ProductState = .available
    @State private var showingImagePicker = false
    
    @ObservedObject private var viewModel = AddProductViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Datos generales")
                    .font(.headline)
                
                Spacer()
                
                Button("Guardar Product") { }
                    .buttonStyle(GradientButtonStyle(imageLeft: Constants.saveProductImage,
                                                     buttonHeight: Constants.buttonHeight))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: Constants.horizontalSpacing) {
                productInformationView
                
                productDetailView
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.grayBackground)
    }
    
    // MARK: - Product Information
    
    private var productInformationView: some View {
        VStack {
            productTextFild(
                title: "Nombre del producto",
                textValue: $productName
            )
            
            productTextFild(
                title: "Precio",
                textValue: $price.allowOnlyNumbers
            )

            productTextFild(
                title: "Unidades disponibles",
                textValue: $availableUnits
            )
            
            Text("Estado")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Menu {
                ForEach(ProductState.allCases, id: \.self) { productState in
                    Button(productState.title) {
                        withAnimation {
                            selectedState = productState
                        }
                    }
                }
            } label: {
                Text(selectedState.title)
            }
            .menuStyle(.borderlessButton)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, minHeight: Constants.minHeight, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .stroke(.graySecundary)
            }
        }
    }
    
    // MARK: - Product Detail
    
    private var productDetailView: some View {
        VStack(alignment: .leading, spacing: Constants.horizontalSpacing) {
            productTextFild(
                title: "Detalles del producto",
                textValue: $productDetails,
                maxHeight: Constants.detailButtonHeight
            )
                .padding(.vertical)
            
            avatarImage
        }
    }
    
    // MARK: - Photo Picker
    
    private var avatarImage: some View {
        VStack(spacing: Constants.spaceSize) {
            if let productImage = viewModel.productImage {
                productImage
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: Constants.photoMaxHeight)
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .stroke(style: StrokeStyle(dash: [Constants.strokLengths]))
                    .frame(maxWidth: .infinity, maxHeight: Constants.photoMaxHeight)
            }
            
            HStack {
                Image(systemName: Constants.loadingImage)
                
                PhotosPicker("Cargar Imagen", selection: $viewModel.avatarItem, matching: .images)
                    .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: Constants.buttonHeight)
            .background {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .fill(LinearGradient(colors: [.purpleGradient, .blueGradient], 
                                         startPoint: .leading,
                                         endPoint: .trailing))
            }
        }
        .onChange(of: viewModel.avatarItem) {
            viewModel.getProductImage()
        }
    }
    
    private func productTextFild(title: String, textValue: Binding<String>, maxHeight: CGFloat = 35) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title3)
                
                Text("*")
                    .foregroundStyle(.redGradient)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("", text: textValue)
                .textFieldStyle(.plain)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: maxHeight, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                        .stroke(.graySecundary)
                }
        }
        .padding(.bottom)
    }
}

#Preview {
    AddProductView()
}
