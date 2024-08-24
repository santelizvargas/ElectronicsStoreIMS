//
//  AddProductViewModel.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 16/8/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

final class AddProductViewModel: ObservableObject {
    @Published var avatarItem: PhotosPickerItem?
    @Published var productImage: Image?
    @Published var isRequestInProgress: Bool = false
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var stock: String = ""
    @Published var description: String = ""
    
    private let productManager: ProductManager = ProductManager()
    
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
    
    func createProduct(completion: (() -> Void)?) {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await productManager.createProduct(name: name,
                                                       description: description,
                                                       salePrice: Double(price) ?? .zero,
                                                       purchasePrice: Double(price) ?? .zero,
                                                       stock: Int(stock) ?? .zero)
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
