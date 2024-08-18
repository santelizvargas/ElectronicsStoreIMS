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
    @Binding private var navigationPath: NavigationPath
    
    // FIXME: - Delete mock credentials
    @State private var email: String = "derianricardo451@gmail.com"
    @State private var password: String = "password3"
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    
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
                
                Button("Iniciar sesión") {
                    viewModel.login(email: email, password: password)
                }
                .buttonStyle(GradientButtonStyle(buttonWidth: Constants.loginButtonMaxWidth,
                                                 gradientColors: [.imsLightBlue, .imsLightPurple])
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(IMSBackground())
        .overlay {
            if viewModel.requestInProgress {
                ProgressView()
            }
        }
        .onChange(of: viewModel.loginSuccess) {_, newValue in
            navigationPath.append(newValue)
        }
        .onAppear {
            viewModel.checkIsUserLogged()
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView(navigationPath: .constant(NavigationPath()))
}
