//
//  IMSUserTextField.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 18/8/24.
//

import SwiftUI

private enum Constants {
    static let frameHeight: CGFloat = 35
    static let horizontalPadding: CGFloat = 8
    static let cornerRadius: CGFloat = 8
    static let trailingPadding: CGFloat = 8
    static let eyeIconPadding: CGFloat = 8
    
    enum Placeholder {
        static let opacity: CGFloat = 1
        static let hiddenOpacity: CGFloat = 0
        static let lineLimit: Int = 1
    }
}

enum IMSUserTextFieldType {
    case text, password, email
}

// MARK: - IMS User Textfiled

struct IMSUserTextField: View {
    @Binding private var text: String
    @State private var isSecure: Bool = false
    
    private let title: String
    private let placeholder: String
    private let isRequired: Bool
    private let isDisabled: Bool
    private let type: IMSUserTextFieldType
    
    init(text: Binding<String>,
         title: String,
         placeholder: String,
         isRequired: Bool = true,
         isDisabled: Bool = false,
         type: IMSUserTextFieldType = .text) {
        _text = text
        self.title = title
        self.placeholder = placeholder
        self.isRequired = isRequired
        self.isDisabled = isDisabled
        self.type = type
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title) + Text(" *").foregroundStyle(isRequired ? .red : .clear)
            
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .lineLimit(Constants.Placeholder.lineLimit)
                    .foregroundStyle(.gray)
                    .opacity(text.isEmpty ? Constants.Placeholder.opacity : Constants.Placeholder.hiddenOpacity)
                
                if isSecure {
                    SecureField("", text: $text)
                        .disabled(isDisabled)
                        .textFieldStyle(.plain)
                } else {
                    TextField("", text: $text)
                        .disabled(isDisabled)
                        .textFieldStyle(.plain)
                }
            }
            .frame(height: Constants.frameHeight)
            .padding(.horizontal, Constants.horizontalPadding)
            .foregroundStyle(.black)
            .onAppear {
                isSecure = type == .password
            }
            .background {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(.white)
            }
            .overlay(alignment: .trailing) {
                if type == .password, !isDisabled {
                    Button {
                        withAnimation {
                            isSecure.toggle()
                        }
                    } label: {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .padding(.trailing, Constants.eyeIconPadding)
                            .foregroundStyle(.gray)
                            .background(.imsWhite)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
