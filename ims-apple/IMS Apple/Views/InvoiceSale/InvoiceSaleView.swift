//
//  SupplyingProductView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 12/8/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 30
    static let buttonHeight: CGFloat = 40
    static let textFieldWidth: CGFloat = 300
    static let cornerRadius: CGFloat = 12
    static let hasBorder: Bool = true
}

struct InvoiceSaleView: View {
    @State private var nameValue = ""
    @State private var phoneNumberValue = ""
    @State private var quantityValue = ""
    @State private var descriptionValue = ""
    @State private var priceValue = ""
    @State private var totalValue = ""
    
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
                .buttonStyle(GradientButtonStyle(imageLeft: "eye",
                                                 buttonHeight: Constants.buttonHeight,
                                                 gradientColors: [.redGradient, .orangeGradient]))
            
            Button("Generar Factura") { }
                .buttonStyle(GradientButtonStyle(imageLeft: "square.and.arrow.down.on.square.fill",
                                                 buttonHeight: Constants.buttonHeight))
        }
        .padding(.vertical)
    }
    
    // MARK: - Client Information
    
    private var clientInformatioView: some View {
        HStack(spacing: Constants.spacing) {
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
                    .buttonStyle(GradientButtonStyle(imageLeft: "plus",
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
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(.secondaryBackground)
            }
        }
    }
}

#Preview {
    InvoiceSaleView()
}
