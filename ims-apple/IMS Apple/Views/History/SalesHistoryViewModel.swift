//
//  SalesHistoryViewModel.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 27/8/24.
//

import Foundation

final class SalesHistoryViewModel: ObservableObject {
    @Published var invoices: [InvoiceModel] = []
    @Published var isRequestInProgress: Bool = false
    
    private lazy var invoiceManager: InvoiceManager = InvoiceManager()
    
    init() {
        getInvoices()
    }
    
    func getInvoices() {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                invoices = try await invoiceManager.getInvoices()
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}
