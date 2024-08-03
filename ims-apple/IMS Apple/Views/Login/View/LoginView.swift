//
//  LoginView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/26/24.
//

import SwiftUI

private enum Constants {
    static let containerMaxWidth: Double = 353
    static let containerSpacing: Double = 25
}

struct LoginView: View {
    
    // MARK: - Properties
    
    @State private var password: String = ""
    @State private var email: String = ""
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: Constants.containerSpacing) {
            
            Text("Iniciar sesión")
                .font(.largeTitle)
            
            Text("Bienvenido! Por favor ingrese sus credenciales")
                .font(.title2)
                .foregroundStyle(.gray)
            
            IMSTextField(type: .email, text: $email)
            IMSSecureField(text: $password)
            
            VStack(alignment: .trailing, spacing: Constants.containerSpacing) {
                Button {
                    /// Do something
                } label: {
                    Text("Olvidaste la contraseña?")
                        .font(.title3)
                        .foregroundStyle(.gray)
                }
                .buttonStyle(.plain)
                
                Button("Iniciar sesión") { }
                    .buttonStyle(ActionButtonStyle(gradientColors: [.imsLightPurple, .imsLightBlue]))
            }
            .frame(maxWidth: Constants.containerMaxWidth)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(IMSBackground())
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}   
