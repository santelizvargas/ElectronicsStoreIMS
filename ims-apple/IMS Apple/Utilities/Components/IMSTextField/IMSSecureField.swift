//
//  IMSSecureField.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/30/24.
//

import SwiftUI

private enum Constants {
    static let secureFieldMaxWidth: Double = 353
    static let secureFieldMaxHeight: Double = 74
    static let secureButtonTrailingPadding: Double = 8
    static let secureButtonImage: String = "eye.slash"
    static let nonSecureButtonImage: String = "eye"
}

struct IMSSecureField: View {
    @Binding private var text: String
    @State private var isSecure: Bool = true
    
    init(text: Binding<String>) {
        _text = text
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Contraseña")
            
            ZStack(alignment: .trailing) {
                
                textField
                    .textFieldStyle(IMSStyle())
                
                Button {
                    isSecure.toggle()
                } label: {
                    Image(
                        systemName: isSecure
                        ? Constants.secureButtonImage
                        : Constants.nonSecureButtonImage
                    )
                }
                .padding(.trailing, Constants.secureButtonTrailingPadding)
            }
        }
        .frame(maxWidth: Constants.secureFieldMaxWidth, maxHeight: Constants.secureFieldMaxHeight)
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
