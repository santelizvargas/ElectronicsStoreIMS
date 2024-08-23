//
//  SupplyingProductView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 12/8/24.
//

import SwiftUI

private enum Constants {
    static let spacingSize: CGFloat = 30
    static let imageSize: CGFloat = 20
    static let buttonHeight: CGFloat = 40
    static let textFieldWidth: CGFloat = 300
    static let hasBorder: Bool = true
    static let addRowImage: String = "plus"
    static let previewImage: String = "eye"
    static let generateInvoiceImage: String = "square.and.arrow.down.on.square.fill"
}

struct InvoiceSaleView: View {
    
    @ObservedObject private var viewModel: InvoiceSaleViewModel = InvoiceSaleViewModel()
    
    var body: some View {
        VStack {
            headerView
            
            VStack {
                clientInformationView
                
                invoiceDetailsView
            }
            .isOS(.iOS) { $0.onKeyboardAppear() }
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.grayBackground)
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Text("Relleno de Producto")
            
            Spacer()
            
            Button("Previsualizar") { }
                .buttonStyle(GradientButtonStyle(imageLeft: Constants.previewImage,
                                                 buttonHeight: Constants.buttonHeight,
                                                 gradientColors: [.redGradient, .orangeGradient]))
            
            Button("Generar Factura") {
                
            }
            .buttonStyle(GradientButtonStyle(imageLeft: Constants.generateInvoiceImage,
                                             buttonHeight: Constants.buttonHeight))
        }
        .padding(.vertical)
    }
    
    // MARK: - Client Information
    
    private var clientInformationView: some View {
        HStack(spacing: Constants.spacingSize) {
            IMSTextField(
                type: .custom("Nombre de cliente"),
                text: $viewModel.invoiceSaleModel.clientName,
                hasBorder: true,
                maxWidth: .infinity
            )
            
            IMSTextField(
                type: .custom("Teléfono"),
                text: $viewModel.invoiceSaleModel.clientPhoneNumber.allowOnlyNumbers,
                hasBorder: true,
                maxWidth: .infinity
            )
        }
        .padding(.vertical)
    }
    
    // MARK: Invoice Details
    
    private var invoiceDetailsView: some View {
        VStack {
            HStack {
                Text("Detalles de Factura")
                
                Spacer()
                
                Button("Agregar fila") {
                    viewModel.addInvoiceRow()
                }
                .buttonStyle(GradientButtonStyle(imageLeft: Constants.addRowImage,
                                                 buttonHeight: Constants.buttonHeight))
            }
            .padding(.vertical)
            
            VStack {
                headerGrid
                invoiceGridRows
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.secondaryBackground)
            }
        }
    }
    
    private var headerGrid: some View {
        Grid {
            GridRow {
                Group {
                    Text("Cantidad")
                    Text("Description")
                    Text("P. Producto")
                    Text("P. Total")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.imsWhite)
                
                Text(" ")
            }
        }
    }
    
    private var invoiceGridRows: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach($viewModel.invoiceSaleModel.products) { $product in
                    GridRow {
                        IMSTextField(text: $product.amount,
                                     hasBorder: true)
                        
                        IMSTextField(text: $product.description,
                                     hasBorder: true, maxWidth: .infinity)
                        
                        IMSTextField(text: $product.unitPrice,
                                     hasBorder: true)
                        
                        IMSTextField(text: .constant(
                            totalPrice(
                                amount: $product.amount,
                                price: $product.unitPrice
                            )
                        ),
                        hasBorder: true)
                        .disabled(true)
                        
                        Button {
                            viewModel.removeInvoiceRow(at: product.id)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: Constants.imageSize, height: Constants.imageSize)
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    private func totalPrice(amount: Binding<String>, price: Binding<String>) -> String {
        if let quantity = Double(amount.wrappedValue), let price = Double(price.wrappedValue) {
            let result = quantity * price
            return result.truncatingRemainder(dividingBy: 1) == .zero
            ? "\(Double(result))"
            : String(format: "%.2f", result)
        } else {
            return "0"
        }
    }
}

#Preview {
    InvoiceSaleView()
}
