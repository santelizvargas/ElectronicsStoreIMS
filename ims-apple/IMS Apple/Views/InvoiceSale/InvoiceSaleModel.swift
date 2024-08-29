//
//  InvoiceSaleModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import Foundation

struct InvoiceSaleModel {
    var id: Int = 0
    var clientName: String = ""
    var clientIdentification: String = ""
    var createAt: String = Date().dayMonthYear
    var products: [InvoiceSaleRowModel] = [.init()]
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

struct InvoiceSaleRowModel: Hashable {
    var idString: String = UUID().uuidString
    var id: String = ""
    var name: String = ""
    var quantity: String = "1"
    var price: Double = 0
    var totalPrice: Double = 0
    
    func getParameters() -> [String: Any] {
        [
            "id": Int(id) ?? 0,
            "name": name,
            "quantity": Int(quantity) ?? 0,
            "price": price
        ]
    }
}
