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
    @Published var name: String = "Color carton"
    @Published var price: String = "69"
    @Published var stock: String = "69"
    @Published var description: String = "Description"
    
    var isCreateDisabled: Bool {
        name.isEmpty ||
        price.isEmpty ||
        description.isEmpty ||
        stock.isEmpty
    }
    
    private func resetProductProperties() {
        name = ""
        price = ""
        stock = ""
        description = ""
        productImage = nil
        avatarItem = nil
    }
    
    private let productManager: ProductManager = ProductManager()
    private var imageData: Data?
    
    func getProductImage() {
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
                                                       category: ProductCategory.all.title,
                                                       imageData: [imageData])
                isRequestInProgress = false
                resetProductProperties()
                completion?()
            } catch {
                isRequestInProgress = false
                completion?()
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
