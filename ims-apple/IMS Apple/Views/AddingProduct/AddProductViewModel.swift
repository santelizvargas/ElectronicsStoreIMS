//
//  AddProductViewModel.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 16/8/24.
//

import SwiftUI
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
    @Published var state: String = ""
    
    private let productManager: ProductManager = ProductManager()
    
    private func resetProductProperties() {
        name = ""
        price = ""
        stock = ""
        description = ""
        state = ""
        productImage = nil
        avatarItem = nil
    }
    
    func getProductImage() {
        Task { @MainActor in
            do {
                if let imageLoaded = try await avatarItem?.loadTransferable(type: Image.self) {
                    productImage = imageLoaded
                } else {
                    debugPrint("Avatar item is currently nil")
                }
            } catch {
                debugPrint("Failed loading the image with error: \(error.localizedDescription)")
            }
        }
    }
    
    func createProduct() {
        guard !name.isEmpty,
              !price.isEmpty,
              !price.isEmpty,
              !stock.isEmpty
        else {
            debugPrint("Some properties are required.")
            return
        }
        
        isRequestInProgress = true
        Task {
            do {
                try await productManager.createProduct(name: name,
                                                       description: description,
                                                       salePrice: Double(price) ?? 0,
                                                       purchasePrice: Double(price) ?? 0,
                                                       stock: Int(stock) ?? 0)
                isRequestInProgress = false
                resetProductProperties()
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
