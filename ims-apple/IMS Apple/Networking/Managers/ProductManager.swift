//
//  ProductManager.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/19/24.
//

import Foundation

final class ProductManager {
    private let networkManager: NetworkManager = NetworkManager()
    
    func getProducts() async throws -> [ProductModel] {
        do {
            let data = try await networkManager.makeRequest(path: .products)
            let products = try JSONDecoder().decode(GetProductResponse.self, from: data)
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
                       stock: Int = 1,
                       category: String,
                       imageData: [Data]) async throws {
        let parameters: [String: Any] = [
            "name": name,
            "description": description,
            "salePrice": salePrice,
            "purchasePrice": purchasePrice,
            "category": category,
            "stock": stock
        ]
        
        do {
            let data = try await networkManager.makeMultipartRequest(path: .products,
                                                                     with: parameters,
                                                                     dataCollection: imageData)
            let response = try JSONDecoder().decode(CreateProductResponse.self, from: data)
            if response.data == nil, response.code == 500 { throw IMSError.uniqueNameKey }
            debugPrint("---\(response.message)---")
        } catch {
            throw error
        }
    }
    
    func deleteProduct(with id: Int) async throws {
        let parameters: [String: Any] = [
            "id": id
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .products, with: parameters, httpMethod: .delete)
            let response = try JSONDecoder().decode(DeleteProductResponse.self, from: data)
            if response.code == 500 { throw IMSError.productNotFound }
            debugPrint("---\(response.message)---")
        } catch {
            throw error
        }
    }
    
    func supplyProduct(id: Int, with stock: Double) async throws {
        let parameters: [String: Any] = [
            "id": id,
            "stock": stock
        ]
        
        do {
            let data = try await networkManager.makeRequest(path: .products, with: parameters, httpMethod: .put)
            let response = try JSONDecoder().decode(CreateProductResponse.self, from: data)
            if response.code == 500 { throw IMSError.productNotFound }
            debugPrint("---\(response.message)---")
        } catch {
            throw error
        }
    }
}
