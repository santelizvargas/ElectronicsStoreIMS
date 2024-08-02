//
//  IMSSecureField.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/30/24.
//

import SwiftUI

private enum Constants {
    static let textFieldMaxWidth: Double = 353
    static let textFieldMaxHeight: Double = 74
    static let secureButtonXOffset: Double = -8
}

struct IMSSecureField: View {
    
    @Binding var text: String
    @State private var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Contraseña")
            
            ZStack(alignment: .trailing) {
                
                textField
                    .textFieldStyle(IMSStyle())
                
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                }
                .offset(x: Constants.secureButtonXOffset)
            }
        }
        .frame(maxWidth: Constants.textFieldMaxWidth, maxHeight: Constants.textFieldMaxHeight)
    }
    
    @ViewBuilder
    private var textField: some View {
        if isSecure {
            SecureField("", text: $text)
        } else {
            TextField("", text: $text)
        }
    }
}

#Preview {
    IMSSecureField(text: .constant(""))
}
