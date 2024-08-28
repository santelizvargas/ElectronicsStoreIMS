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

enum IMSTextFieldType: Equatable {
    case custom(String)
    case email
    case none
    
    var title: String {
        switch self {
            case .custom(let title): title
            case .email: "Email"
            case .none: ""
        }
    }
}

struct IMSTextField: View {
    @Binding private var text: String
    private let hasBorder: Bool
    private let maxWidth: CGFloat
    private let minHeight: CGFloat
    private let type: IMSTextFieldType
    private let isActive: Bool
    private let placeholder: String
    
    init(type: IMSTextFieldType = .none,
         text: Binding<String>,
         placeholder: String = "",
         hasBorder: Bool = false,
         isActive: Bool = true,
         maxWidth: CGFloat = Constants.textFieldMaxWidth,
         minHeight: CGFloat = Constants.textFieldMinHeight) {
        self.type = type
        _text = text
        self.hasBorder = hasBorder
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.isActive = isActive
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack {
            if type != .none {
                HStack {
                    Text(type.title)
                        .font(.title3)
                    
                    Spacer()
                }
            }
            
            TextField(placeholder, text: $text)
                .textFieldStyle(IMSTextFieldStyle(textFieldMinHeight: minHeight, isActive: isActive))
                .overlay {
                    if hasBorder {
                        RoundedRectangle(cornerRadius: Constants.cornerRadiusSize)
                            .stroke(.graySecundary)
                    }
                }
        }
        .frame(maxWidth: maxWidth, maxHeight: Constants.textFieldMaxHeight)
        .allowsHitTesting(isActive)
    }
}

#Preview {
    IMSTextField(type: .custom("Text field"), text: .constant(""))
}
