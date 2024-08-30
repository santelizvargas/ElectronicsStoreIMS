//
//  InvoicePreviewView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 22/8/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 20
    static let userSpacing: CGFloat = 8
    static let gridSpacing: CGFloat = 4
    static let totalSpacing: CGFloat = 20
    static let productGridSpacing: CGFloat = 30
    static let cornerRadius: CGFloat = 10
    static let maxWidth: CGFloat = 700
    static let minHeight: CGFloat = 600
    static let logoSize: CGFloat = 150
    static let ivaValue: CGFloat = 0.15
}

// MARK: - Invoice Preview View

struct InvoicePreviewView: View {
    private let invoiceSale: InvoiceSaleModel
    
    init(invoiceSale: InvoiceSaleModel) {
        self.invoiceSale = invoiceSale
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            contentView
        }
        .padding(.vertical)
        .padding(.horizontal, Constants.productGridSpacing)
        .frame(
            minHeight: Constants.minHeight,
            maxHeight: .infinity
        )
        .frame(width: Constants.maxWidth)
        .foregroundStyle(.black)
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.imsWhite)
        }
        .overlay(alignment: .bottomLeading) {
            ExportPDFButton(fileName: "Factura \(Date().dayMonthYear)", color: .black) {
                contentView
                    .padding(.vertical)
                    .padding(.horizontal, Constants.productGridSpacing)
                    .frame(
                        minHeight: Constants.minHeight,
                        maxHeight: .infinity
                    )
                    .frame(width: Constants.maxWidth)
                    .foregroundStyle(.black)
                    .background {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .fill(.imsWhite)
                    }
            }
            .padding()
            .background(.imsWhite)
        }
    }
    
    private var contentView: some View {
        VStack(spacing: Constants.spacing) {
            headerView
            
            VStack(alignment: .leading, spacing: Constants.userSpacing) {
                Text("+505 8942 6818")
                Text(verbatim: "info@electronic.store")
                Text("Catedral de León 2C al Norte, León - Nicaragua")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.imsGraySecundary)
            
            VStack(alignment: .leading, spacing: Constants.userSpacing) {
                Text("Datos del cliente")
                    .font(.title3.bold())
                
                Grid(alignment: .leading, verticalSpacing: Constants.gridSpacing) {
                    GridRow {
                        Text("Nombre:")
                        Text(invoiceSale.clientName)
                            .foregroundStyle(.imsGraySecundary)
                    }
                    
                    GridRow {
                        Text("Identificacion:")
                        Text(invoiceSale.clientIdentification)
                            .foregroundStyle(.imsGraySecundary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: Constants.userSpacing) {
                Text("Detalles de factura")
                    .font(.title3.bold())
                
                Grid(alignment: .leading, horizontalSpacing: Constants.productGridSpacing, verticalSpacing: Constants.totalSpacing) {
                    GridRow {
                        Text("Cantidad")
                        Text("Descripción")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("P. Unitario")
                        Text("P. Total")
                    }
                    .bold()
                    
                    ForEach(invoiceSale.products, id: \.idString) { product in
                        GridRow {
                            Text(product.quantity.description)
                            Text(product.name)
                            Text("$\(getDoubleFormat(for: product.price))")
                            Text("$\(getDoubleFormat(for: product.totalPrice))")
                        }
                        .foregroundStyle(.imsGray)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .strokeBorder(.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Grid(alignment: .leading, horizontalSpacing: Constants.totalSpacing) {
                totalGridRow(name: "Subtotal:", value: invoiceSale.subtotalPrice)
                totalGridRow(name: "IVA:", value: invoiceSale.totalIva)
                totalGridRow(name: "Total:", value: invoiceSale.totalPrice)
            }
            .padding([.horizontal, .bottom])
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer()
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Image(.imsLogoBlack)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.logoSize)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: Constants.userSpacing) {
                Text("Factura: ")
                    .bold()
                + Text(invoiceSale.id > .zero ? invoiceSale.id.description : "-")
                
                Text(invoiceSale.createAt)
                    .foregroundStyle(.imsGraySecundary)
            }
        }
    }
    
    // MARK: - Total Grid Row
    
    private func totalGridRow(name: String, value: Double) -> some View {
        GridRow {
            Text(name)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text("$\(getDoubleFormat(for: value))")
        }
    }
    
    // MARK: - Get Double Format
    
    func getDoubleFormat(for value: Double) -> String {
        return value.truncatingRemainder(dividingBy: 1) == .zero
        ? String(format: "%.0f", value)
        : String(format: "%.2f", value)
    }
}

