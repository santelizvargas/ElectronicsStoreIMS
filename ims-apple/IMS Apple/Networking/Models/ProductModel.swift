//
//  ProductModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 12/8/24.
//

import Foundation

struct CreateProductResponse: Decodable {
    let message: String
    let code: Int
    let data: ProductModel?
}

struct GetProductResponse: Decodable {
    let data: [ProductModel]
}

struct ProductCountResponse: Decodable {
    let message: String
    let data: ProductCount
}

struct DeleteProductResponse: Decodable {
    let message: String
    let code: Int
}

struct ProductCount: Decodable {
    let quantity: Int
}

struct ProductModel: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    var category: ProductCategory
    let description: String
    let stock: Int
    let salePrice: Double
    let purchasePrice: Double
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    var images: [String] = []

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case description
        case stock
        case salePrice
        case purchasePrice
        case createdAt
        case updatedAt
        case deletedAt
        case images
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        stock = try container.decode(Int.self, forKey: .stock)
        salePrice = try container.decode(Double.self, forKey: .salePrice)
        purchasePrice = try container.decode(Double.self, forKey: .purchasePrice)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        deletedAt = try container.decodeIfPresent(String.self, forKey: .deletedAt)
        images = try container.decode([String].self, forKey: .images)
        
        let categoryValue = try container.decode(String.self, forKey: .category)
        category = ProductCategory(rawValue: categoryValue) ?? .all
    }
}
