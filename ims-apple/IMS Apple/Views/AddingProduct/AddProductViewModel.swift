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
}
