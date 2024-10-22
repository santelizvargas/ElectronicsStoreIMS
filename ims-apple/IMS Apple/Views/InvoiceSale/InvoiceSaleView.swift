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
    static let minOpacity: CGFloat = 0.6
    static let maxOpacity: CGFloat = 1
    static let hasBorder: Bool = true
    static let addRowImage: String = "plus"
    static let previewImage: String = "eye"
    static let generateInvoiceImage: String = "square.and.arrow.down.on.square.fill"
}

struct InvoiceSaleView: View {
    @ObservedObject private var viewModel: InvoiceSaleViewModel = InvoiceSaleViewModel()
    @State private var showProductList: Bool = false
    @State private var showInvoicePreview: Bool = false
    @State private var showAlert: Bool = false
    
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
        .overlay {
            if viewModel.isRequestInProgress {
                CustomProgressView()
            }
        }
        .alert(
            viewModel.disableGenerateInvoice
            ? "Factura Creada Correctamente"
            : "¡Ups! Algo salió mal. Por favor, intenta de nuevo más tarde.",
            isPresented: $showAlert
        ) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Text("Relleno de Producto")
            
            Spacer()
            
            Button("Previsualizar") {
                withAnimation {
                    showInvoicePreview.toggle()
                }
            }
            .buttonStyle(
                GradientButtonStyle(
                    imageLeft: Constants.previewImage,
                    buttonHeight: Constants.buttonHeight,
                    gradientColors: [.redGradient, .orangeGradient]
                )
            )
            .disabled(viewModel.disableGenerateInvoice)
            .opacity(viewModel.disableGenerateInvoice ? Constants.minOpacity : Constants.maxOpacity)
            .isOS(.iOS) { view in
                view.sheet(isPresented: $showInvoicePreview) {
                    InvoicePreviewView(invoiceSale: viewModel.invoiceSaleModel)
                }
            }
            .isOS(.macOS) { view in
                view.popover(isPresented: $showInvoicePreview) {
                    InvoicePreviewView(invoiceSale: viewModel.invoiceSaleModel)
                }
            }
            
            Button("Generar Factura") {
                withAnimation {
                    viewModel.createInvoice {
                        showAlert.toggle()
                    }
                }
            }
            .buttonStyle(
                GradientButtonStyle(
                    imageLeft: Constants.generateInvoiceImage,
                    buttonHeight: Constants.buttonHeight
                )
            )
            .disabled(viewModel.disableGenerateInvoice)
            .opacity(viewModel.disableGenerateInvoice ? Constants.minOpacity : Constants.maxOpacity)
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
                type: .custom("Identificacion del cliente"),
                text: $viewModel.invoiceSaleModel.clientIdentification,
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
                
                Button("Ver codigos") {
                    withAnimation {
                        showProductList = true
                    }
                }
                .buttonStyle(GradientButtonStyle(imageLeft: Constants.previewImage))
                .isOS(.iOS) { view in
                    view.sheet(isPresented: $showProductList) {
                        ProductCodeView(products: viewModel.currentProducts)
                    }
                }
                .isOS(.macOS) { view in
                    view.popover(isPresented: $showProductList) {
                        ProductCodeView(products: viewModel.currentProducts)
                    }
                }
                
                Button("Agregar fila") {
                    viewModel.addInvoiceRow()
                }
                .buttonStyle(
                    GradientButtonStyle(
                        imageLeft: Constants.addRowImage,
                        buttonHeight: Constants.buttonHeight
                    )
                )
                .disabled(viewModel.disableAddNewRow)
                .opacity(viewModel.disableAddNewRow ? Constants.minOpacity : Constants.maxOpacity)
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
                    Text("Codigo")
                    Text("Cantidad")
                    Text("Description")
                    Text("P. Unitario")
                    Text("P. Total")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.imsWhite)
                
                Text("").frame(width: Constants.imageSize)
            }
        }
    }
    
    private var invoiceGridRows: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach(Array($viewModel.invoiceSaleModel.products.enumerated()), id: \.offset) { index, $product in
                    GridRow {
                        IMSTextField(
                            text: $product.id.allowOnlyNumbers,
                            hasBorder: true,
                            isActive: index == .zero
                        )
                        .onChange(of: product.id) { _, id in
                            viewModel.setProductValues(for: id, with: &product)
                            viewModel.setTotalPrice(for: &product)
                        }
                        
                        IMSTextField(
                            text: $product.quantity.allowOnlyNumbers,
                            hasBorder: true,
                            isActive: index == .zero
                        )
                        
                        IMSTextField(
                            text: $product.name,
                            hasBorder: true,
                            isActive:  false,
                            maxWidth: .infinity
                        )
                        
                        IMSTextField(
                            text: .constant(
                                viewModel.getDoubleFormat(for: product.price)
                            ),
                            hasBorder: true,
                            isActive: false
                        )
                        
                        IMSTextField(
                            text: .constant(viewModel.getDoubleFormat(for: product.totalPrice)),
                            hasBorder: true,
                            isActive: false
                        )
                        .onChange(of: product.quantity) { _, _ in
                            viewModel.setTotalPrice(for: &product)
                        }
                        
                        Button {
                            viewModel.removeInvoiceRow(at: product.idString)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: Constants.imageSize, height: Constants.imageSize)
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                        .disabled(viewModel.disableRemoveRow)
                        .opacity(viewModel.disableRemoveRow ? Constants.minOpacity : Constants.maxOpacity)
                    }
                }
            }
        }
    }
}

#Preview {
    InvoiceSaleView()
}
