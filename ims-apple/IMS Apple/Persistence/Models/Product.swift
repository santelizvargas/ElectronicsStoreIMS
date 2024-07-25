//
//  Product.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 22/7/24.
//

import SwiftData

@Model
final class Product {
    @Attribute(.unique) var id: String
    @Attribute(.unique) var name: String
    var stock: Int
    
    init(id: String, name: String, stock: Int) {
        self.id = id
        self.name = name
        self.stock = stock
    }
}
