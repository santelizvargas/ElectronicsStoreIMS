//
//  InvoiceModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 27/8/24.
//

import Foundation

struct InvoiceModelResponse: Decodable {
    let data: [InvoiceModel]
}

struct InvoiceModel: Decodable, Identifiable {
    let id: Int
    let customerName: String
    let customerIdentification: String
    let totalAmount: Int
    let createdAt: String
    let products: [ProductModel]
}
