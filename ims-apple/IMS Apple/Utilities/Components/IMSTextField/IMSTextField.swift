//
//  IMSTextField.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/28/24.
//

import SwiftUI

private enum Constants {
    static let textFieldMaxWidth: Double = 353
    static let textFieldMaxHeight: Double = 74
    static let cornerRadiusSize: CGFloat = 8
}

enum IMSTextFieldType {
    case custom(String)
    case email
    
    var title: String {
        switch self {
            case .custom(let title): title
            case .email: "Email"
        }
    }
}

struct IMSTextField: View {
    @Binding private var text: String
    private let hasBorder: Bool
    
    private let type: IMSTextFieldType
    
    init(type: IMSTextFieldType,
         text: Binding<String>,
         hasBorder: Bool = false) {
        self.type = type
        _text = text
        self.hasBorder = hasBorder
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(type.title)
                    .font(.title3)
                
                Spacer()
            }
            
            TextField("", text: $text)
                .textFieldStyle(IMSTextFieldStyle())
                .overlay {
                    if hasBorder {
                        RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                            .stroke(.graySecundary)
                    }
                }
        }
        .frame(maxWidth: Constants.textFieldMaxWidth, maxHeight: Constants.textFieldMaxHeight)
    }
}

#Preview {
    IMSTextField(type: .custom("Text field"), text: .constant(""))
}
