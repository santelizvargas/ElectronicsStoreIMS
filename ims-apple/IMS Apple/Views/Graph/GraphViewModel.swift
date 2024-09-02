//
//  GraphViewModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import Foundation

final class GraphViewModel: ObservableObject {
    @Published var productCount: Int = .zero
    @Published var enabledUserCount: Int = .zero
    @Published var disabledUserCount: Int = .zero
    @Published var invoiceCount: Int = .zero
    @Published var categoriesBars: [BarItem] = []
    @Published var productBars: [BarItem] = []
    @Published var isRequestInProgress: Bool = false
    
    private lazy var productManager: ProductManager = ProductManager()
    private lazy var invoiceManager: InvoiceManager = InvoiceManager()
    private lazy var authenticationManager: AuthenticationManager = AuthenticationManager()
    
    init() {
        loadData()
    }
    
    func loadData() {
        isRequestInProgress = true
        getProductCount()
        getUserCount()
        getInvoices()
    }
    
    private func getProductCount() {
        Task { @MainActor in
            do {
                productCount = try await productManager.getProductCount()
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func getUserCount() {
        Task { @MainActor in
            do {
                let response = try await authenticationManager.getUserCounts()
                enabledUserCount = response.usersCount
                disabledUserCount = response.suspendedCount
            } catch {
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func getInvoices() {
        Task { @MainActor in
            do {
                let response = try await invoiceManager.getInvoices()
                createBarItems(from: response)
                productBars = createBarItemsForLast7Days(from: response)
                invoiceCount = response.count
                try await Task.sleep(nanoseconds: 1_000_000_000)
                isRequestInProgress = false
            } catch {
                isRequestInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func countCategories(in sales: [InvoiceModel]) -> [String: Int] {
        var categoryCount: [String: Int] = [:]
        
        sales.forEach { sale in
            sale.details.forEach { detail in
                if let productCategory = sale.products.first(where: { $0.name == detail.productName })?.category {
                    categoryCount[productCategory.rawValue, default: .zero] += detail.productQuantity
                }
            }
        }
        
        return categoryCount
    }
    
    private func createBarItems(from sales: [InvoiceModel]) {
        let categoryCount = countCategories(in: sales)
        
        categoriesBars = ProductCategory.categories.map { category in
            let count = categoryCount[category.rawValue, default: .zero]
            return BarItem(name: category.rawValue, value: Double(count))
        }
    }
    
    func countProductsSoldInLast7Days(in sales: [InvoiceModel]) -> [String: Int] {
        var productsSoldByDay: [String: Int] = [:]
        
        let calendar = Calendar.current
        let currentDate = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        sales.forEach { sale in
            sale.details.forEach { detail in
                if let date = dateFormatter.date(from: String(sale.createdAt.yearMonthDay)) {
                    if date >= sevenDaysAgo && date <= currentDate {
                        let dayFormatter = DateFormatter()
                        dayFormatter.locale = Locale(identifier: "es_ES")
                        dayFormatter.dateFormat = "EEEE"
                        let dayName = dayFormatter.string(from: date).capitalized
                        productsSoldByDay[dayName, default: 0] += detail.productQuantity
                    }
                }
            }
        }
        
        return productsSoldByDay
    }
    
    func createBarItemsForLast7Days(from sales: [InvoiceModel]) -> [BarItem] {
        let productsSoldByDay = countProductsSoldInLast7Days(in: sales)
        
        let calendar = Calendar.current
        let currentDate = Date()
        var barItems: [BarItem] = []
        
        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: "es_ES") // Configurar el locale en español
        dayFormatter.dateFormat = "EEEE"
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: currentDate) {
                let dayName = dayFormatter.string(from: date).capitalized
                let quantity = productsSoldByDay[dayName, default: 0]
                barItems.append(BarItem(name: dayName, value: Double(quantity)))
            }
        }
        
        return barItems.reversed()
    }
}

