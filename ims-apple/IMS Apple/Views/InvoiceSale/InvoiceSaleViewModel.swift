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
        products: [.init()]
    )
    
    @Published var currentProducts: [ProductModel] = []
    
    private lazy var productManager: ProductManager = ProductManager()
    
    init() {
        getProducts()
    }
    
    func addInvoiceRow() {
        invoiceSaleModel.products.append(InvoiceSaleRowModel())
    }
    
    func removeInvoiceRow(at id: UUID) {
        invoiceSaleModel.products.removeAll(where: { $0.id == id })
    }
    
    func getProducts() {
        Task { @MainActor in
            do {
                currentProducts = try await productManager.getProducts()
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func totalPrice(amount: String, price: Double) -> String {
        guard let quantity = Double(amount) else { return "0" }
        let result = quantity * price
        return getDoubleFormat(for: result)
    }
    
    func getDoubleFormat(for value: Double) -> String {
        return value.truncatingRemainder(dividingBy: 1) == .zero
        ? String(format: "%.0f", value)
        : String(format: "%.2f", value)
    }
}
