//
//  SalesHistoryView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 5/8/24.
//

import SwiftUI

private enum HistoryConstants {
    static let columnsNumber: Int = 4
    static let horizontalPadding: CGFloat = 32
    static let cornerRadius: CGFloat = 12
    
    enum Button {
        static let height: CGFloat = 36
        static let cornerRadius: CGFloat = 4
    }
}

struct SalesHistoryView: View {
    private let columns: [GridItem] = Array(repeating: GridItem(), count: HistoryConstants.columnsNumber)
    var body: some View {
        VStack {
            Text("Todas las ventas")
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                headerListView
                
                Divider()
                
                historyList
            }
            .background(.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: HistoryConstants.cornerRadius))
            
            pageButtons
                .padding()
        }
        .padding()
        .background(.grayBackground)
    }
    
    private var pageButtons: some View {
        HStack {
            Button("Anterior") { }
                .buttonStyle(GradientButtonStyle(imageLeft: "chevron.left",
                                                 buttonHeight: HistoryConstants.Button.height,
                                                 cornerRadius: HistoryConstants.Button.cornerRadius))
            
            ForEach(1...5, id: \.self) { number in
                Button("\(number)") { }
                    .buttonStyle(GradientButtonStyle(buttonHeight: HistoryConstants.Button.height,
                                                     cornerRadius: HistoryConstants.Button.cornerRadius))
            }
            
            Button("Siguiente") { }
                .buttonStyle(GradientButtonStyle(imageRight: "chevron.right",
                                                 buttonHeight: HistoryConstants.Button.height,
                                                 cornerRadius: HistoryConstants.Button.cornerRadius))
        }
    }
    
    private var headerListView: some View {
        LazyVGrid(columns: columns) {
            Group {
                Text("Cliente")
                Text("Telefono")
                Text("Fecha de Compra")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.vertical, .trailing])
        }
        .padding(.leading, HistoryConstants.horizontalPadding)
    }
    
    private var historyList: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(HistoryModel.mockData) { user in
                    Group {
                        Text(user.name)
                        Text(user.phoneNumber)
                        Text(user.date)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.vertical, .trailing])
                    
                    Button("Ver Factura") { }
                        .underline()
                        .buttonStyle(.plain)
                        .foregroundStyle(.blue)
                }
            }
        }
        .padding(.leading, HistoryConstants.horizontalPadding)
    }
}

#Preview {
    SalesHistoryView()
}
