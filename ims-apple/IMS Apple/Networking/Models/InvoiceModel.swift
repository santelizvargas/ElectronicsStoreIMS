//
//  InvoiceModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 27/8/24.
//

import Foundation

struct InvoiceModelResponse: Decodable {
    let data: [InvoiceModel]
}

struct InvoiceModel: Decodable, Identifiable {
    let id: Int
    let customerName: String
    let customerIdentification: String
    let totalAmount: Double
    let createdAt: String
    let products: [ProductModel]
    let details: [DetailsInvoiceModel]
}

struct DetailsInvoiceModel: Decodable {
    let id: Int
    let productName: String
    let productQuantity: Int
    let productPrice: Double
    let productCategory: String?
    let invoiceId: Int
    let createdAt: String
}
