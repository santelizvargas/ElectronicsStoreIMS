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
    static let photoMaxHeight: CGFloat = 200
    static let detailButtonHeight: CGFloat = 70
    static let strokLengths: CGFloat = 10
    static let spaceSize: CGFloat = 10
    static let minOpacity: CGFloat = 0.6
    static let maxOpacity: CGFloat = 1
    static let loadingImage: String = "square.and.arrow.down"
    static let saveProductImage: String = "square.and.arrow.down.on.square.fill"
}

struct AddProductView: View {
    @State private var selectedCategory: ProductCategory = .phones
    @State private var showingImagePicker: Bool = false
    @State private var showAlert: Bool = false
    
    @ObservedObject private var viewModel = AddProductViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Datos generales")
                    .font(.headline)
                
                Spacer()
                
                Button("Agregar producto") {
                    viewModel.createProduct {
                        withAnimation {
                            showAlert.toggle()
                        }
                    }
                }
                .buttonStyle(
                    GradientButtonStyle(
                        imageLeft: Constants.saveProductImage,
                        buttonHeight: Constants.buttonHeight
                    )
                )
                .disabled(viewModel.isCreateDisabled)
                .opacity(viewModel.isCreateDisabled ? Constants.minOpacity : Constants.maxOpacity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .top, spacing: Constants.horizontalSpacing) {
                productInformationView
                
                productDetailView
            }
            .isOS(.iOS) { $0.onKeyboardAppear() }
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.grayBackground)
        .alert(
            viewModel.name.isEmpty
            ? "Producto Agregado Correctamente"
            : "¡Ups! Algo salió mal. Por favor, intenta de nuevo más tarde.",
            isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
    }
    
    // MARK: - Product Information
    
    private var productInformationView: some View {
        VStack {
            productTextFild(
                title: "Nombre del producto",
                textValue: $viewModel.name
            )
            
            productTextFild(
                title: "Precio",
                textValue: $viewModel.price.allowOnlyDecimalNumbers
            )

            productTextFild(
                title: "Unidades disponibles",
                textValue: $viewModel.stock.allowOnlyNumbers
            )
            
            categoryButton
        }
    }
    
    // MARK: - Product Detail
    
    private var productDetailView: some View {
        VStack(alignment: .leading, spacing: Constants.horizontalSpacing) {
            VStack(alignment: .leading) {
                Text("Detalles del producto")
                    .font(.title3) +
                Text(" *")
                    .foregroundStyle(.redGradient)
                
                TextField("", text: $viewModel.description, axis: .vertical)
                    .textFieldStyle(.plain)
                    .frame(minHeight: Constants.detailButtonHeight)
                    .overlay {
                        RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                            .stroke(.graySecundary)
                    }
            }
            
            avatarImage
        }
    }
    
    // MARK: - Photo Picker
    
    private var avatarImage: some View {
        VStack(spacing: Constants.spaceSize) {
            if let productImage = viewModel.productImage {
                productImage
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: Constants.photoMaxHeight)
                    .clipped()
                    .allowsHitTesting(false)
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .stroke(style: StrokeStyle(dash: [Constants.strokLengths]))
                    .frame(maxWidth: .infinity, minHeight: Constants.photoMaxHeight)
            }
            
            HStack {
                Image(systemName: Constants.loadingImage)
                
                PhotosPicker("Cargar Imagen", selection: $viewModel.avatarItem, matching: .images)
                    .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, minHeight: Constants.buttonHeight)
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
    
    // MARK: - Category Button
    
    private var categoryButton: some View {
        VStack(alignment: .leading) {
            Text("Categoria")
                .font(.title3)
            +
            Text(" *")
                .foregroundStyle(.redGradient)
            
            Menu {
                ForEach(ProductCategory.categories, id: \.self) { category in
                    Button(category.title) {
                        selectedCategory = category
                    }
                }
            } label: {
                Text(selectedCategory.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                    .isOS(.iOS) { view in
                        view.padding(Constants.spaceSize)
                    }
            }
            .menuStyle(.borderlessButton)
            .isOS(.macOS) { view in
                view.padding(Constants.spaceSize)
            }
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .stroke(.graySecundary)
            }
            .contentShape(Rectangle())
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
