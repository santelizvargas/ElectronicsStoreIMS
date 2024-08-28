//
//  AddProductViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 16/8/24.
//

import SwiftUI
import CoreGraphics
import _PhotosUI_SwiftUI

@MainActor
final class AddProductViewModel: ObservableObject {
    @Published var avatarItem: PhotosPickerItem?
    @Published var productImage: Image?
    @Published var isRequestInProgress: Bool = false
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var stock: String = ""
    @Published var description: String = ""
    @Published var category: ProductCategory = .phones
    
    var isCreateDisabled: Bool {
        name.isEmpty ||
        price.isEmpty ||
        description.isEmpty ||
        stock.isEmpty ||
        imageData == nil ||
        avatarItem == nil
    }
    
    private func resetProductProperties() {
        name = ""
        price = ""
        stock = ""
        description = ""
        productImage = nil
        avatarItem = nil
    }
    
    var addProductRequestMessage: String = ""
    
    private let productManager: ProductManager = ProductManager()
    private var imageData: Data?
    
    func getProductImage(completion: (() -> Void)?) {
        Task { @MainActor in
            do {
                if let image = try await avatarItem?.loadTransferable(type: Image.self) {
                    productImage = image
                    let renderer = ImageRenderer(content: image)
                    
                    if let cgImage = renderer.cgImage {
                        let data = NSMutableData()
                        guard let imageDestination = CGImageDestinationCreateWithData(data as CFMutableData,
                                                                                      UTType.jpeg.identifier as CFString,
                                                                                      1, nil)
                        else { return }
                        
                        CGImageDestinationAddImage(imageDestination, cgImage, nil)
                        
                        if CGImageDestinationFinalize(imageDestination) {
                            imageData = data as Data
                        }
                    }
                }
            } catch {
                addProductRequestMessage = "Formato de imagen no soportado!"
                completion?()
                debugPrint("Failed loading the image with error: \(error.localizedDescription)")
            }
        }
    }
    
    func createProduct(completion: (() -> Void)?) {
        guard let imageData
        else {
            debugPrint("Please select a product image.")
            return
        }
        
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await productManager.createProduct(name: name,
                                                       description: description,
                                                       salePrice: Double(price) ?? .zero,
                                                       purchasePrice: Double(price) ?? .zero,
                                                       stock: Int(stock) ?? .zero,
                                                       category: category.rawValue,
                                                       imageData: [imageData])
                isRequestInProgress = false
                resetProductProperties()
                completion?()
                addProductRequestMessage = "Producto agregado correctamente!"
            } catch {
                isRequestInProgress = false
                completion?()
                guard let error = error as? IMSError else { return }
                addProductRequestMessage = error == .uniqueNameKey
                ? "El nombre del producto ya existe, por favor ingrese uno diferente!"
                : "¡Ups! Algo salió mal. Por favor, intenta de nuevo más tarde."
                debugPrint(error.localizedDescription)
            }
        }
    }
}
