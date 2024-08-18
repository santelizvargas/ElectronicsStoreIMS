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
    static let textFieldMinHeight: CGFloat = 30
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
    private let maxWidth: CGFloat
    private let minHeight: CGFloat
    
    private let type: IMSTextFieldType
    
    init(type: IMSTextFieldType,
         text: Binding<String>,
         hasBorder: Bool = false,
         maxWidth: CGFloat = Constants.textFieldMaxWidth,
         minHeight: CGFloat = Constants.textFieldMinHeight) {
        self.type = type
        _text = text
        self.hasBorder = hasBorder
        self.maxWidth = maxWidth
        self.minHeight = minHeight
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(type.title)
                    .font(.title3)
                
                Spacer()
            }
            
            TextField("", text: $text)
                .textFieldStyle(IMSTextFieldStyle(textFieldMinHeight: minHeight))
                .overlay {
                    if hasBorder {
                        RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                            .stroke(.graySecundary)
                    }
                }
        }
        .frame(maxWidth: maxWidth, maxHeight: Constants.textFieldMaxHeight)
    }
}

#Preview {
    IMSTextField(type: .custom("Text field"), text: .constant(""))
}
