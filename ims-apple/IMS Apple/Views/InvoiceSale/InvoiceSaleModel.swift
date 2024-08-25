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
    var code: String
    var amount: String
    var description: String
    var unitPrice: Double
    var totalPrice: Double
    
    init(code: String = "",
         amount: String = "",
         description: String = "",
         unitPrice: Double = 0,
         totalPrice: Double = 0) {
        self.code = code
        self.amount = amount
        self.description = description
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
    }
}