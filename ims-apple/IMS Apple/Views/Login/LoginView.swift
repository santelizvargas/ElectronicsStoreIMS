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
    static let launchViewHeight: Double = 200
}

struct LoginView: View {
    @Binding private var navigationPath: NavigationPath
    
    // FIXME: - Delete mock credentials
    @State private var email: String = "brandon.santeliz@example.com"
    @State private var password: String = "password5"
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    
    var body: some View {
        VStack(spacing: Constants.containerSpacing) {
            if viewModel.isShowLaunchScreen {
                launchView
            } else {
                Text("Iniciar sesión")
                    .font(.largeTitle)
                
                Text("Bienvenido! Por favor ingrese sus credenciales")
                    .font(.title2)
                    .foregroundStyle(.gray)
                
                IMSTextField(type: .email, text: $email)
                IMSSecureField(text: $password)
                
                Button("Iniciar sesión") {
                    withAnimation {
                        viewModel.login(email: email, password: password)
                    }
                }
                .buttonStyle(GradientButtonStyle(buttonWidth: Constants.loginButtonMaxWidth,
                                                 gradientColors: [.imsLightBlue, .imsLightPurple]))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(IMSBackground())
        .overlay {
            if viewModel.requestInProgress {
                CustomProgressView()
            }
        }
        .onReceive(viewModel.$loginSuccess) { isLoginSuccess in
            if isLoginSuccess {
                navigationPath.append(true)
                email = ""
                password = ""
            }
        }
        .onAppear {
            viewModel.checkIsUserLogged()
        }
        .alert("¡Ups! Algo salió mal. Por favor, intenta de nuevo más tarde.", isPresented: $viewModel.isLoginError) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private var launchView: some View {
        VStack {
            Image(.imsLogoWhite)
                .resizable()
                .scaledToFit()
                .frame(height: Constants.launchViewHeight)
            
            CustomProgressView()
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView(navigationPath: .constant(NavigationPath()))
}

