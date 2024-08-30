//
//  RegisterUserView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 20
    static let minOpacity: CGFloat = 0.6
    static let maxOpacity: CGFloat = 1
    static let gridCellColumns: Int = 2
    static let gridPadding: CGFloat = 30
    static let gridMinWidth: CGFloat = 600
}

struct RegisterUserView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var isReloadUsers: Bool
    @ObservedObject private var viewModel: RegisterUserViewModel = .init()
    @State private var isShowErrorMessage: Bool = false
    
    init(isReloadUsers: Binding<Bool>) {
        _isReloadUsers = isReloadUsers
    }
    
    var body: some View {
        Grid(horizontalSpacing: Constants.spacing, verticalSpacing: Constants.spacing) {
            GridRow {
                IMSUserTextField(
                    text: $viewModel.userInfo.firstName,
                    title: "Nombres",
                    placeholder: "Ingrese sus nombres"
                )
                
                IMSUserTextField(
                    text: $viewModel.userInfo.lastName,
                    title: "Apellidos",
                    placeholder: "Ingrese sus apellidos"
                )
            }
            
            GridRow {
                IMSUserTextField(
                    text: $viewModel.userInfo.identification,
                    title: "Identificacion",
                    placeholder: "Ingrese su identificacion"
                )
                
                IMSUserTextField(
                    text: $viewModel.userInfo.phone.allowOnlyNumbers,
                    title: "Telefono",
                    placeholder: "Ingrese su telefono"
                )
            }
            
            GridRow {
                IMSUserTextField(
                    text: $viewModel.userInfo.address,
                    title: "Direccion",
                    placeholder: "Ingrese su direccion"
                )
                
                IMSUserTextField(
                    text: $viewModel.userInfo.email,
                    title: "Email",
                    placeholder: "Ingrese su email"
                )
            }
            
            GridRow(alignment: .bottom) {
                IMSUserTextField(
                    text: $viewModel.userInfo.password,
                    title: "Contraseña",
                    placeholder: "Ingrese su contraseña",
                    type: .password
                )
                
                IMSUserTextField(
                    text: $viewModel.userInfo.confirmPassword,
                    title: "Confirmar contraseña",
                    placeholder: "Confirme contraseña",
                    type: .password
                )
            }
            
            GridRow {
                Button("Registrar") {
                    if viewModel.userInfo.password == viewModel.userInfo.confirmPassword {
                        withAnimation {
                            viewModel.registerUser()
                        }
                    } else {
                        withAnimation {
                            isShowErrorMessage = true
                        }
                    }
                }
                .buttonStyle(GradientButtonStyle(buttonWidth: .infinity))
                .opacity(viewModel.userInfo.someFieldsAreEmpty() ? Constants.minOpacity : Constants.maxOpacity)
                .disabled(viewModel.userInfo.someFieldsAreEmpty())
                .gridCellColumns(Constants.gridCellColumns)
            }
            
            if isShowErrorMessage {
                GridRow {
                    Text("Algo salio mal! Por favor revisa que las contraseñas coincidan")
                        .underline()
                        .foregroundStyle(.red)
                        .gridCellColumns(Constants.gridCellColumns)
                }
            }
        }
        .padding(Constants.gridPadding)
        .background(.secondaryBackground)
        .frame(minWidth: Constants.gridMinWidth)
        .onReceive(viewModel.$isRegistered) { isRegistered in
            guard isRegistered else { return }
            viewModel.isRegistered = false
            isReloadUsers = true
            dismiss()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                Image(systemName: "xmark")
                    .contentShape(Rectangle())
            }
            .padding()
        }
        .isOS(.iOS) { $0.onKeyboardAppear() }
    }
}

#Preview {
    RegisterUserView(isReloadUsers: .constant(false))
}
