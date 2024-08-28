//
//  InvoiceSaleViewModel.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/23/24.
//

import Foundation

final class InvoiceSaleViewModel: ObservableObject {
    @Published var invoiceSaleModel: InvoiceSaleModel = .init()
    @Published var currentProducts: [ProductModel] = []
    @Published var isRequestInProgress: Bool = false
    
    var disableRemoveRow: Bool {
        invoiceSaleModel.products.count == 1
    }
    
    var disableAddNewRow: Bool {
        invoiceSaleModel.products.contains { producto in
            producto.name.isEmpty || producto.quantity.isEmpty
        }
    }
    
    var disableGenerateInvoice: Bool {
        invoiceSaleModel.clientName.isEmpty ||
        invoiceSaleModel.clientIdentification.isEmpty ||
        disableAddNewRow
    }
    
    private lazy var productManager: ProductManager = ProductManager()
    private lazy var invoiceManager: InvoiceManager = InvoiceManager()
    
    init() {
        getProducts()
    }
    
    func addInvoiceRow() {
        invoiceSaleModel.products.insert(InvoiceSaleRowModel(), at: .zero)
    }
    
    func removeInvoiceRow(at id: String) {
        invoiceSaleModel.products.removeAll(where: { $0.id == id })
    }
    
    func setProductValues(for id: String, with product: inout InvoiceSaleRowModel) {
        guard
            let productId = Int(id.trimmingCharacters(in: .whitespaces)),
            let currentProduct = currentProducts.first(where: { $0.id == productId })
        else {
            product.name = ""
            product.price = .zero
            return
        }
        product.name = currentProduct.name
        product.price = currentProduct.salePrice
    }
    
    func setTotalPrice(for product: inout InvoiceSaleRowModel) {
        guard let amount = Double(product.quantity) else {
            product.totalPrice = .zero
            return
        }
        product.totalPrice = amount * product.price
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
    
    func createInvoice(completion: (() -> Void)?) {
        isRequestInProgress = true
        Task { @MainActor in
            do {
                try await invoiceManager.createInvoice(invoice: invoiceSaleModel)
                invoiceSaleModel = .init()
                isRequestInProgress = false
                completion?()
            } catch {
                isRequestInProgress = false
                completion?()
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
