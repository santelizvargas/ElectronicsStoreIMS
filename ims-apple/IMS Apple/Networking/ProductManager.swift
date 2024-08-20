//
//  ProductManager.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/19/24.
//

import Foundation

final class ProductManager {
    private let networkManager: NetworkManager = NetworkManager()
    
    func getProducts() async throws -> [ProductModel] {
        do {
            let data = try await networkManager.makeRequest(path: .getProducts, with: [:])
            let products = try JSONDecoder().decode(ProductResponse.self, from: data)
            return products.data
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
