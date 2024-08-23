//
//  InvoiceSaleModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import Foundation

struct InvoiceSaleModel {
    let clientName: String
    let clientPhoneNumber: String
    let articles: [InvoiceSaleView]
}

struct InvoiceSaleRowModel {
    let amount: Int
    let description: String
    let unitPrice: Double
    let totalPrice: Double
}
