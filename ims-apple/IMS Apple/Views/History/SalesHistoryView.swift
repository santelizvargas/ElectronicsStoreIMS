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
    @State private var showInvoicePreview: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Todas las ventas")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ExporterButton(
                    title: "Exportar",
                    fileName: "Historial de ventas",
                    collection: viewModel.invoices
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
                    ForEach(Array(viewModel.invoices.enumerated()), id: \.offset) { index, item in
                        GridRow {
                            Group {
                                Text(item.customerName)
                                Text(item.customerIdentification)
                                Text(item.createdAt.dayMonthYear)
                                Button("Ver factura") {
                                    withAnimation {
                                        viewModel.selectedSale = viewModel.invoicesPreview[index]
                                    }
                                }
                                .buttonStyle(.plain)
                                .underline()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical)
                    }
                }
                .onReceive(viewModel.$selectedSale) { sale in
                    if sale != nil {
                        showInvoicePreview.toggle()
                    }
                }
                .isOS(.iOS) { view in
                    view.sheet(isPresented: $showInvoicePreview) {
                        if let selectedSale = viewModel.selectedSale {
                            InvoicePreviewView(invoiceSale: selectedSale)
                        }
                    }
                }
                .isOS(.macOS) { view in
                    view.popover(isPresented: $showInvoicePreview) {
                        if let selectedSale = viewModel.selectedSale {
                            InvoicePreviewView(invoiceSale: selectedSale)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .gridCellColumns(Constants.columnsNumber)
        }
        .refreshable {
            viewModel.getInvoices()
        }
        .isOS(.macOS) { view in
            view.toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: viewModel.getInvoices) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.imsWhite)
                    }
                }
            }
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
