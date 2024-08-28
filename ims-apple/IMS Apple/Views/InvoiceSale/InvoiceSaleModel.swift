//
//  InvoiceSaleModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import Foundation

struct InvoiceSaleModel {
    var clientName: String
    var clientIdentification: String
    let createAt: String
    var products: [InvoiceSaleRowModel]
    
    init(clientName: String = "",
         clientIdentification: String = "",
         createAt: String = Date().dayMonthYear,
         products: [InvoiceSaleRowModel] = [.init()]) {
        self.clientName = clientName
        self.clientIdentification = clientIdentification
        self.createAt = createAt
        self.products = products
    }
}

extension InvoiceSaleModel {
    var subtotalPrice: Double {
        products.reduce(.zero) { result, product in
            let price = product.totalPrice
            return result + price
        }
    }
    
    var totalIva: Double { subtotalPrice * 0.15 }
    var totalPrice: Double { subtotalPrice + totalIva }
}

struct InvoiceSaleRowModel: Identifiable {
    var id: String
    var name: String
    var quantity: String
    var price: Double
    var totalPrice: Double
    
    init(id: String = "",
         name: String = "",
         quantity: String = "1",
         price: Double = 0,
         totalPrice: Double = 0) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
        self.totalPrice = totalPrice
    }
    
    func getParameters() -> [String: Any] {
        [
            "id": Int(id) ?? 0,
            "name": name,
            "quantity": Int(quantity) ?? 0,
            "price": price
        ]
    }
}
