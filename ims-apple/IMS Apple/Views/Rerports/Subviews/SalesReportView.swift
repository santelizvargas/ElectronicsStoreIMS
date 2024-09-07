//
//  SalesReportView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 6/9/24.
//

import SwiftUI

struct SalesReportView: View {
    private let sales: [InvoiceModel]
    private let timeAgo: Int?
    
    init(sales: [InvoiceModel], timeAgo: Int? = nil) {
        self.sales = sales
        self.timeAgo = timeAgo
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            VStack(spacing: 5) {
                Grid { getGridRow() }
                
                CustomDivider(color: .imsGraySecundary.opacity(0.5))
                    .padding(.bottom)
                
                salesList
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.secondaryBackground)
            }
            
            footerView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
    
    private var salesList: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach(sales) { sale in
                    getGridRow(
                        cod: sale.id.description,
                        client: sale.customerName,
                        id: sale.customerIdentification,
                        date: sale.createdAt.dayMonthYear,
                        total: getDoubleFormat(for: sale.totalAmount),
                        isHeader: false
                    )
                    
                    GridRow {
                        CustomDivider(color: .imsGraySecundary.opacity(0.5))
                            .padding(.vertical)
                            .gridCellColumns(5)
                    }
                }
            }
        }
    }
    
    private func getGridRow(
        cod: String = "#",
        client: String = "Cliente",
        id: String = "Identificacion",
        date: String = "Regitrada",
        total: String = "Total",
        isHeader: Bool = true
    ) -> some View {
        GridRow {
            Text(cod).frame(width: 50)
            
            Group {
                Text(date)
                Text(client)
                Text(id)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(total).frame(width: 100)
        }
        .fontWeight(isHeader ? .bold : .regular)
    }
    
    private func totalItem(
        title: String,
        count: Int? = nil,
        total: Double? = nil
    ) -> some View {
        HStack {
            Text(title).bold()
            
            if let total {
                Text("\(getDoubleFormat(for: total))")
            }
            
            if let count {
                Text(count.description)
            }
        }
        .padding(.horizontal)
        .frame(height: 30)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.secondaryBackground)
        }
    }
    
    private var footerView: some View {
        HStack {
            
            if let timeFilter {
               totalItem(title: timeFilter)
            }
            
            totalItem(
                title: "Total de facturas:",
                count: sales.count
            )
            
            totalItem(
                title: "Valor en ventas:",
                total: sales.map { $0.totalAmount }.reduce(.zero, +)
            )
        }
    }
    
    private var timeFilter: String? {
        let today = Date()
        
        guard let timeAgo,
              let date = Calendar.current.date(byAdding: .day, 
                                               value: -timeAgo,
                                               to: today)
        else { return nil }
        return "\(date.dayMonthYear) - \(today.dayMonthYear)"
    }
    
    func getDoubleFormat(for value: Double) -> String {
        return value.truncatingRemainder(dividingBy: 1) == .zero
        ? String(format: "$%.0f", value)
        : String(format: "$%.2f", value)
    }
}
