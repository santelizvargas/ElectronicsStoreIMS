//
//  InvoiceSaleRow.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/22/24.
//

import SwiftUI

private enum Constants {
        static let cornerRadiusSize: CGFloat = 12
}

struct InvoiceSaleRow: View {
    @State private var quantityValue: String = ""
    @State private var descriptionValue: String = ""
    @State private var priceValue: String = ""
    
    var body: some View {
        HStack {
            IMSTextField(text: $quantityValue.allowOnlyNumbers,
                         hasBorder: true)
            
            IMSTextField(text: $descriptionValue,
                         hasBorder: true, maxWidth: .infinity)
            
            IMSTextField(text: $priceValue.allowOnlyDecimalNumbers,
                         hasBorder: true)
            
            IMSTextField(text: .constant(totalPrice),
                         hasBorder: true)
            .disabled(true)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                .fill(.secondaryBackground)
        }
    }
    
    private var totalPrice: String {
        if let quantity = Double(quantityValue), let price = Double(priceValue) {
            let result = quantity * price
            return result.truncatingRemainder(dividingBy: 1) == .zero
            ? "\(Int(result))"
            : String(format: "%.2f", result)
        } else {
            return "0"
        }
    }
}

#Preview {
    InvoiceSaleRow()
}
