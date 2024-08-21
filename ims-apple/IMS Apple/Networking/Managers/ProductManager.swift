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
            let data = try await networkManager.makeRequest(path: .products)
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
    
    func createProduct(name: String,
                       description: String,
                       salePrice: Double,
                       purchasePrice: Double,
                       stock: Int = 1) async throws {
        let parameters: [String: Any] = [
            "name": name,
            "description": description,
            "salePrice": salePrice,
            "purchasePrice": purchasePrice,
            "stock": stock
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .products, with: parameters, httpMethod: .post)
            let response = try JSONDecoder().decode(CreateProductResponse.self, from: data)
            if response.data == nil, response.code == 500 { throw IMSError.uniqueNameKey }
        } catch {
            throw error
        }
    }
}
