//
//  SalesHistoryViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 27/8/24.
//

import Foundation

final class SalesHistoryViewModel: ObservableObject {
    @Published var invoices: [InvoiceModel] = []
    @Published var invoicesPreview: [InvoiceSaleModel] = []
    @Published var isRequestInProgress: Bool = false
    @Published var selectedSale: InvoiceSaleModel?
    
    private lazy var invoiceManager: InvoiceManager = InvoiceManager()
    
    init() {
        getInvoices()
    }
    
    func getInvoices() {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                let sales = try await invoiceManager.getInvoices()
                invoices = sales.sorted { $0.createdAt > $1.createdAt }
                mapInvoicePreview()
                try await Task.sleep(nanoseconds: 1_000_000_000)
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func mapInvoicePreview() {
        invoicesPreview = invoices.map { invoice in
            let products = invoice.details.map { detail in
                InvoiceSaleRowModel(
                    id: detail.id.description,
                    name: detail.productName,
                    quantity: detail.productQuantity.description,
                    price: detail.productPrice,
                    totalPrice: Double(detail.productQuantity) * detail.productPrice
                )
            }
            
            return InvoiceSaleModel(
                id: invoice.id,
                clientName: invoice.customerName,
                clientIdentification: invoice.customerIdentification,
                createAt: invoice.createdAt.dayMonthYear,
                products: products
            )
        }
    }
}
