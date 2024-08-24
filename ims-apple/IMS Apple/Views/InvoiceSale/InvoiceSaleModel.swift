//
//  InvoiceSaleModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import Foundation

struct InvoiceSaleModel {
    var clientName: String
    var clientPhoneNumber: String
    var date: Date = .now
    var products: [InvoiceSaleRowModel]
}

struct InvoiceSaleRowModel: Identifiable {
    let id: UUID = UUID()
    var amount: String
    var description: String
    var unitPrice: String
    var totalPrice: String
    
    init(amount: String = "",
         description: String = "",
         unitPrice: String = "",
         totalPrice: String = "") {
        self.amount = amount
        self.description = description
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
    }
}
