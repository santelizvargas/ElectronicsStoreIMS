//
//  InvoiceManager.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 27/8/24.
//

import Foundation

struct InvoiceProductModel: Codable {
    let id: Int
    let name: String
    let quantity: Int
    let price: Double
}

final class InvoiceManager {
    private let networkManager: NetworkManager = NetworkManager()
    
    func getInvoices() async throws -> [InvoiceModel] {
        do {
            let data = try await networkManager.makeRequest(path: .invoices)
            let products = try JSONDecoder().decode(InvoiceModelResponse.self, from: data)
            return products.data
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    func createInvoice(invoice: InvoiceSaleModel) async throws {
        let parameters: [String: Any] = [
            "customerName": invoice.clientName,
            "customerIdentification": invoice.clientIdentification,
            "totalAmount": invoice.totalPrice,
            "products": invoice.products.map { $0.getParameters() }
        ]
        
        do {
            try await networkManager.makeRequest(path: .invoices,
                                                 with: parameters,
                                                 httpMethod: .post)
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
