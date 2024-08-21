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
            let data = try await networkManager.makeRequest(path: .getProducts)
            let products = try JSONDecoder().decode(ProductResponse.self, from: data)
            return products.data
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    func getProductCount() async throws -> Int {
        do {
            let data = try await networkManager.makeRequest(path: .productCount)
            let products = try JSONDecoder().decode(ProductCountResponse.self, from: data)
            return products.data.quantity
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
