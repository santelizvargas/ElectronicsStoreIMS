//
//  InvoiceSaleViewModel.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/23/24.
//

import Foundation

final class InvoiceSaleViewModel: ObservableObject {
    @Published var invoiceSaleModel: InvoiceSaleModel = InvoiceSaleModel(
        clientName: "",
        clientPhoneNumber: "",
        products: []
    )
    
    func addInvoiceRow() {
        invoiceSaleModel.products.append(InvoiceSaleRowModel())
    }
    
    func removeInvoiceRow(at id: UUID) {
        invoiceSaleModel.products.removeAll(where: { $0.id == id })
    }
}
