//
//  InvoiceManager.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 27/8/24.
//

import Foundation

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
}
