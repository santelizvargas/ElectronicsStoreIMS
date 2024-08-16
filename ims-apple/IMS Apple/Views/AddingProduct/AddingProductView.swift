//
//  AddingProductView.swift
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
    static let cornerRadiusSize: CGFloat = 10
    static let photoMaxHeight: CGFloat = 120
    static let detailButtonHeight: CGFloat = 70
    static let strokLengths: CGFloat = 10
    static let spaceSize: CGFloat = 10
    static let loadingImage: String = "square.and.arrow.down"
    static let saveProductImage: String = "square.and.arrow.down.on.square.fill"
}

struct AddingProductView: View {
    @State private var productName: String = ""
    @State private var price: String = ""
    @State private var availableUnits: String = ""
    @State private var productDetails: String = ""
    @State private var state: String = ""
    @State private var selectedState: String = "Disponible"
    @State private var showingImagePicker = false
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
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
                
                productDetailsView
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
            IMSTextField(
                type: .custom("Nombre del producto"),
                text: $productName,
                hasBorder: Constants.hasBorder,
                maxWidth: .infinity
            )
            
            IMSTextField(
                type: .custom("Precio"),
                text: $price,
                hasBorder: Constants.hasBorder,
                maxWidth: .infinity
            )
            
            IMSTextField(
                type: .custom("Unidades disponibles"),
                text: $availableUnits,
                hasBorder: Constants.hasBorder,
                maxWidth: .infinity
            )
            
            Text("Estado")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Menu {
                ForEach(["Disponible", "Ocupado", "Agotado"], id: \.self) { item in
                    Button(item) {
                        withAnimation {
                            selectedState = item
                        }
                    }
                }
            } label: {
                Text(selectedState)
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
    
    private var productDetailsView: some View {
        VStack(alignment: .leading, spacing: Constants.horizontalSpacing) {
            IMSTextField(
                type: .custom("Detalles del producto"),
                text: $productDetails,
                hasBorder: Constants.hasBorder,
                maxWidth: .infinity,
                minHeight: Constants.detailButtonHeight
            )
            .padding(.vertical)
            
            photoPickerView
        }
    }
    
    // MARK: - Photo Picker
    
    private var photoPickerView: some View {
        VStack(spacing: Constants.spaceSize) {
            if let avatarImage {
                avatarImage
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: Constants.photoMaxHeight)
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .stroke(style: StrokeStyle(dash: [Constants.strokLengths]))
                    .frame(maxWidth: .infinity, maxHeight: Constants.photoMaxHeight)
            }
            
            HStack {
                Image(systemName: Constants.loadingImage)
                
                PhotosPicker("Cargar Imagen", selection: $avatarItem, matching: .images)
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
        .onChange(of: avatarItem) {
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    AddingProductView()
}
