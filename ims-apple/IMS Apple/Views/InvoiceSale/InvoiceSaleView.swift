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
    static let cornerRadiusSize: CGFloat = 12
    static let hasBorder: Bool = true
    static let addRowImage: String = "plus"
    static let previewImage: String = "eye"
    static let generateInvoiceImage: String = "square.and.arrow.down.on.square.fill"
}

struct InvoiceSaleView: View {
    @State private var nameValue: String = ""
    @State private var phoneNumberValue: String = ""
    @State private var quantityValue: String = ""
    @State private var descriptionValue: String = ""
    @State private var priceValue: String = ""
    @State private var totalValue: String = ""
    
    var body: some View {
        VStack {
            headerView
            
            clientInformatioView
            
            invoiceDetailsView
            
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
            
            Button("Generar Factura") { }
                .buttonStyle(GradientButtonStyle(imageLeft: Constants.generateInvoiceImage,
                                                 buttonHeight: Constants.buttonHeight))
        }
        .padding(.vertical)
    }
    
    // MARK: - Client Information
    
    private var clientInformatioView: some View {
        HStack(spacing: Constants.spacingSize) {
            IMSTextField(type: .custom("Buscar Producto"),
                         text: $nameValue, hasBorder: true)

            IMSTextField(type: .custom("Teléfono"),
                         text: $phoneNumberValue, hasBorder: true)
        }
        .padding(.vertical)
    }
    
    // MARK: Invoice Details
    
    private var invoiceDetailsView: some View {
        VStack {
            HStack {
                Text("Detalles de Factura")
                
                Spacer()
                
                Button("Agregar fila") { }
                    .buttonStyle(GradientButtonStyle(imageLeft: Constants.addRowImage,
                                                     buttonHeight: Constants.buttonHeight))
            }
            .padding(.vertical)
            
            HStack {
                IMSTextField(type: .custom("Cantidad"),
                             text: $quantityValue,
                             hasBorder: Constants.hasBorder)
                
                IMSTextField(type: .custom("Descripcion"),
                             text: $descriptionValue,
                             hasBorder: Constants.hasBorder)
                .frame(minWidth: Constants.textFieldWidth)
                
                IMSTextField(type: .custom("P. Unitartio"),
                             text: $priceValue,
                             hasBorder: Constants.hasBorder)
                
                IMSTextField(type: .custom("P. Total"),
                             text: $totalValue,
                             hasBorder: Constants.hasBorder)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                    .fill(.secondaryBackground)
            }
        }
    }
}

#Preview {
    InvoiceSaleView()
}
