//
//  SalesHistoryView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 5/8/24.
//

import SwiftUI

private enum Constants {
    static let columnsNumber: Int = 4
    static let horizontalPadding: CGFloat = 32
    static let cornerRadius: CGFloat = 12
    static let gridCellColumns: Int = 2
    
    enum Button {
        static let height: CGFloat = 36
        static let width: CGFloat = 33
        static let cornerRadius: CGFloat = 4
    }
}

struct SalesHistoryView: View {
    @ObservedObject private var viewModel: SalesHistoryViewModel = .init()
    
    var body: some View {
        VStack {
            HStack {
                Text("Todas las ventas")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ExporterButton(
                    title: "Exportar",
                    fileName: "Historial de ventas",
                    collection: HistoryModel.mockData
                )
            }
            
            historyList
        }
        .padding()
        .background(.grayBackground)
        .foregroundStyle(.white)
    }
    
    // MARK: - Header List View
    
    private var headerListView: some View {
        Grid(horizontalSpacing: .zero) {
            GridRow {
                Group {
                    Text("Cliente")
                    Text("Identificacion")
                    Text("Fecha")
                        .gridCellColumns(Constants.gridCellColumns)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
        
    // MARK: - History List View
    
    private var historyList: some View {
        Grid {
            headerListView
            
            CustomDivider(color: .graySecundary)
            
            itemRows
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.secondaryBackground)
        }
        .padding(.bottom)
    }
    
    // MARK: - Item View
    
    private var itemRows: some View {
        GridRow {
            ScrollView(showsIndicators: false) {
                Grid(horizontalSpacing: .zero) {
                    ForEach(viewModel.invoices) { item in
                        GridRow {
                            Group {
                                Text(item.customerName)
                                Text(item.customerIdentification)
                                Text(item.createdAt.dayMonthYear)
                                Button("Ver factura") {
                                    
                                }
                                .buttonStyle(.plain)
                                .underline()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .gridCellColumns(Constants.columnsNumber)
        }
        .overlay {
            if viewModel.isRequestInProgress {
                CustomProgressView()
            }
        }
    }
}

#Preview {
    SalesHistoryView()
}
