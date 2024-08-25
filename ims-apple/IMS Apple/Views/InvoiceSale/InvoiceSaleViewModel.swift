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
    
    var disableRemoveRow: Bool {
        invoiceSaleModel.products.count == 1
    }
    
    var disableAddNewRow: Bool {
        invoiceSaleModel.products.contains { producto in
            producto.description.isEmpty || producto.amount.isEmpty
        }
    }
    
    var disableGenerateInvoice: Bool {
        invoiceSaleModel.clientName.isEmpty ||
        invoiceSaleModel.clientPhoneNumber.isEmpty ||
        disableAddNewRow
    }
    
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
    
    func setProductValues(for id: String, with product: inout InvoiceSaleRowModel) {
        guard let productId = Int(id),
              let currentProduct = currentProducts.first(where: { $0.id == productId })
        else {
            product.description = ""
            product.unitPrice = .zero
            return
        }
        product.description = currentProduct.name
        product.unitPrice = currentProduct.salePrice
    }
    
    func setTotalPrice(for product: inout InvoiceSaleRowModel) {
        guard let amount = Double(product.amount) else {
            product.totalPrice = .zero
            return
        }
        product.totalPrice = amount * product.unitPrice
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
