//
//  ProductModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 12/8/24.
//

import Foundation

struct ProductModel: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let detail: String
    let image: String
    let price: Double
    let category: ProductCategory
    let amount: Int
}

extension ProductModel {
    static let products = [
        ProductModel(
            name: "iPhone 14 Pro",
            detail: "Apple iPhone 14 Pro with A15 Bionic chip and advanced camera system.",
            image: "https://picsum.photos/id/0/5000/3333",
            price: 999.99,
            category: .phones,
            amount: 10
        ),
        ProductModel(
            name: "MacBook Pro 16\"",
            detail: "Apple MacBook Pro with M1 chip, 16-inch Retina display, and 16GB RAM.",
            image: "https://picsum.photos/id/1/5000/3333",
            price: 2499.99,
            category: .computers,
            amount: 5
        ),
        ProductModel(
            name: "iPad Air",
            detail: "Apple iPad Air with A14 Bionic chip and 10.9-inch Liquid Retina display.",
            image: "https://picsum.photos/id/2/5000/3333",
            price: 599.99,
            category: .phones,
            amount: 8
        ),
        ProductModel(
            name: "AirPods Pro",
            detail: "Apple AirPods Pro with active noise cancellation and transparency mode.",
            image: "https://picsum.photos/id/3/5000/3333",
            price: 249.99,
            category: .electronicParts,
            amount: 0
        ),
        ProductModel(
            name: "Apple Watch Series 7",
            detail: "Apple Watch Series 7 with a larger display and new health features.",
            image: "https://picsum.photos/id/4/5000/3333",
            price: 399.99,
            category: .electronicParts,
            amount: 12
        ),
        ProductModel(
            name: "iPhone 13 Pro",
            detail: "6.1-inch Super Retina XDR display, A15 Bionic chip, 12MP camera, Water-resistant",
            image: "https://picsum.photos/id/5/5000/3333",
            price: 999.99,
            category: .phones,
            amount: 0
        ),
        ProductModel(
            name: "MacBook Air",
            detail: "13.3-inch Retina display, M1 chip, 8GB RAM, 256GB SSD, Touch ID",
            image: "https://picsum.photos/id/6/5000/3333",
            price: 1299.99,
            category: .computers,
            amount: 7
        ),
        ProductModel(
            name: "iPad Pro",
            detail: "12.9-inch Liquid Retina display, A12X Bionic chip, 12MP camera, Apple Pencil support",
            image: "https://picsum.photos/id/7/5000/3333",
            price: 899.99,
            category: .phones,
            amount: 4
        ),
        ProductModel(
            name: "Apple Watch Series 7",
            detail: "40mm or 44mm case size, GPS, Water-resistant, Heart rate monitoring",
            image: "https://picsum.photos/id/8/5000/3333",
            price: 399.99,
            category: .electronicParts,
            amount: 15
        ),
        ProductModel(
            name: "AirPods Pro",
            detail: "Wireless earbuds, Active Noise Cancellation, Water-resistant, 24 hours battery life",
            image: "https://picsum.photos/id/9/5000/3333",
            price: 249.99,
            category: .electronicParts,
            amount: 0
        )
    ]
}
