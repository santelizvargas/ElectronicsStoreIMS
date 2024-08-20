//
//  ProductModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 12/8/24.
//

import Foundation

struct ProductResponse: Decodable {
    let data: [ProductModel]
}

struct ProductModel: Identifiable, Equatable, Decodable {
    let id: UUID = UUID()
    let name: String
    var category: ProductCategory = .all
    let description: String
    let stock: Int
    let salePrice: Int
    let purchasePrice: Int
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?

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
    }
    
    init(name: String,
         category: ProductCategory,
         description: String,
         stock: Int,
         salePrice: Int,
         purchasePrice: Int, 
         createdAt: String,
         updatedAt: String,
         deletedAt: String?) {
        self.name = name
        self.description = description
        self.stock = stock
        self.salePrice = salePrice
        self.purchasePrice = purchasePrice
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.category = category
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        stock = try container.decode(Int.self, forKey: .stock)
        salePrice = try container.decode(Int.self, forKey: .salePrice)
        purchasePrice = try container.decode(Int.self, forKey: .purchasePrice)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        deletedAt = try container.decodeIfPresent(String.self, forKey: .deletedAt)
    }
}
