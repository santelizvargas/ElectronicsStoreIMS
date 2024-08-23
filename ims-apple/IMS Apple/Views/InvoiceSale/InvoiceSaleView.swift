//
//  SupplyingProductView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 12/8/24.
//

import SwiftUI

private enum Constants {
    static let spacingSize: CGFloat = 30
    static let buttonHeight: CGFloat = 40
    static let textFieldWidth: CGFloat = 300
    static let hasBorder: Bool = true
    static let addRowImage: String = "plus"
    static let previewImage: String = "eye"
    static let generateInvoiceImage: String = "square.and.arrow.down.on.square.fill"
}

struct InvoiceSaleView: View {
    @State private var nameValue: String = ""
    @State private var phoneNumberValue: String = ""
    @State private var invoiceSaleRows: [InvoiceSaleRow] = []
    
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
        .onAppear {
            invoiceSaleRows.append(InvoiceSaleRow())
        }
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
                text: $nameValue,
                hasBorder: true,
                maxWidth: .infinity
            )

            IMSTextField(
                type: .custom("Teléfono"),
                text: $phoneNumberValue.allowOnlyNumbers,
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
                    invoiceSaleRows.append(InvoiceSaleRow())
                }
                    .buttonStyle(GradientButtonStyle(imageLeft: Constants.addRowImage,
                                                     buttonHeight: Constants.buttonHeight))
            }
            .padding(.vertical)
            
            ScrollView {
                ForEach(invoiceSaleRows.indices, id: \.self) { index in
                    invoiceSaleRows[index]
                }
            }
        }
    }
    
}

#Preview {
    InvoiceSaleView()
}
