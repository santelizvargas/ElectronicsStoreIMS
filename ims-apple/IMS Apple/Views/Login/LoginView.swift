//
//  LoginView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/26/24.
//

import SwiftUI

private enum Constants {
    static let loginButtonMaxWidth: Double = 320
    static let containerSpacing: Double = 25
}

struct LoginView: View {
    
    @State private var email: String = "derianricardo451@gmail.com"
    @State private var password: String = "password2"
    
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
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
                    
                    Button("Iniciar sesión") {
                        viewModel.login(email: email, password: password)
                    }
                        .buttonStyle(GradientButtonStyle(
                            buttonWidth: Constants.loginButtonMaxWidth,
                            gradientColors: [.imsLightBlue, .imsLightPurple]
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(IMSBackground())
            
            if viewModel.requestInProgress {
                ProgressView()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}   
