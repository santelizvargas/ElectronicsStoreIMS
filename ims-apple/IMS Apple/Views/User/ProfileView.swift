//
//  ProfileView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 16/8/24.
//

import SwiftUI

private enum Constants {
    static let profileImageSize: CGFloat = 120
    static let circleStrokeOpacity: CGFloat = 0.2
    static let circleMaximun: Int = 2
    static let gridCellColumns: Int = 2
    static let baseCircleSize: CGFloat = 160
    static let baseCircle: Int = 160
    static let circleSizeDecrement: Int = 20
    static let cardWidth: CGFloat = 260
    static let cardHeight: CGFloat = 300
    static let cardMaxHeight: CGFloat = 350
    static let cardSpacing: CGFloat = 10
    static let cardCornerRadius: CGFloat = 10
    static let verticalSpacing: CGFloat = 20
    static let horizontalSpacing: CGFloat = 20
    static let buttonHeight: CGFloat = 35
    static let minOpacity: CGFloat = 0.7
    static let maxOpacity: CGFloat = 1
    static let cancelIcon: String = "xmark"
    static let editIcon: String = "pencil"
}

struct ProfileView: View {
    @ObservedObject private var viewModel: ProfileViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Información del usuario")
                .padding(.vertical)
            
            HStack(alignment: .top) {
                cardInformation
                
                VStack {
                    userInformationForm
                    
                    CustomDivider(color: .imsGraySecundary)
                        .padding(.vertical)
                    
                    userPasswordForm
                        .overlay {
                            if viewModel.isRequestInProgress {
                                CustomProgressView()
                            }
                        }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                        .fill(.secondaryBackground)
                }
            }
            .isOS(.iOS) { $0.onKeyboardAppear() }
            
            Spacer()
        }
        .padding()
        .background(.grayBackground)
    }
    
    // MARK: - Card Information View
    
    private var cardInformation: some View {
        VStack {
            ZStack {
                ProfileImage(
                    fullName: viewModel.shortName,
                    size: Constants.profileImageSize
                )
                
                ForEach(.zero...Constants.circleMaximun, id: \.self) { index in
                    Circle()
                        .stroke(Color.white.opacity(Constants.circleStrokeOpacity))
                        .frame(width: CGFloat(Constants.baseCircle - (index * Constants.circleSizeDecrement)))
                }
            }
            .frame(width: Constants.baseCircleSize, height: Constants.baseCircleSize)
            
            VStack(spacing: Constants.cardSpacing) {
                Text(viewModel.shortName)
                    .font(.title.bold())
                
                Text(["Admin", "User"].joined(separator: " - "))
                    .font(.title2)
                
                Text(viewModel.userInfo.email)
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: Constants.cardWidth)
        .frame(minHeight: Constants.cardHeight, maxHeight: Constants.cardMaxHeight)
        .background {
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(.secondaryBackground)
        }
    }
    
    // MARK: - User Information Form View
    
    private var userInformationForm: some View  {
        Grid(horizontalSpacing: Constants.horizontalSpacing, verticalSpacing: Constants.verticalSpacing) {
            GridRow {
                IMSUserTextField(
                    text: .constant(viewModel.userInfo.names),
                    title: "Nombres",
                    placeholder: "",
                    isRequired: false,
                    isDisabled: true
                )
                
                IMSUserTextField(
                    text: .constant(viewModel.userInfo.lastName),
                    title: "Apellidos",
                    placeholder: "",
                    isRequired: false,
                    isDisabled: true
                )
            }
            
            GridRow(alignment: .bottom) {
                IMSUserTextField(
                    text: .constant(viewModel.userInfo.email),
                    title: "Email",
                    placeholder: "",
                    isRequired: false,
                    isDisabled: true
                )
                .gridCellColumns(Constants.gridCellColumns)
            }
        }
    }
    
    // MARK: - User Password Form
    
    private var userPasswordForm: some View {
        Grid(horizontalSpacing: Constants.horizontalSpacing, verticalSpacing: Constants.verticalSpacing) {
            GridRow {
                IMSUserTextField(
                    text: $viewModel.userPassword.currentPassword,
                    title: "Contraseña actual",
                    placeholder: "Ingrese su contraseña actual",
                    isRequired: viewModel.isPasswordEdit,
                    isDisabled: !viewModel.isPasswordEdit,
                    type: .password
                )
            }
            
            GridRow {
                IMSUserTextField(
                    text: $viewModel.userPassword.newPassword,
                    title: "Nueva Contraseña",
                    placeholder: "Ingrese su nueva contraseña",
                    isRequired: viewModel.isPasswordEdit,
                    isDisabled: !viewModel.isPasswordEdit,
                    type: .password
                )
                
                IMSUserTextField(
                    text: $viewModel.userPassword.confirmPassword,
                    title: "Confirmar Contraseña",
                    placeholder: "Confirme su nueva contraseña",
                    isRequired: viewModel.isPasswordEdit,
                    isDisabled: !viewModel.isPasswordEdit,
                    type: .password
                )
            }
            
            GridRow {
                Button("Guardar contraseña") {
                    viewModel.updatePasswordIfNeeded()
                }
                .buttonStyle(
                    GradientButtonStyle(
                        buttonWidth: .infinity,
                        buttonHeight: Constants.buttonHeight
                    )
                )
                .disabled(viewModel.isSavePasswordDisabled)
                .opacity(viewModel.isSavePasswordDisabled ? Constants.minOpacity : Constants.maxOpacity)
            }
        }
        .opacity(viewModel.isPasswordEdit ? Constants.maxOpacity : Constants.minOpacity)
        .overlay(alignment: .topTrailing) {
            Button(viewModel.isPasswordEdit ? "Cancelar" : "Editar") {
                withAnimation {
                    viewModel.isPasswordEdit.toggle()
                    viewModel.resetPasswordTextfields()
                }
            }
            .buttonStyle(
                GradientButtonStyle(
                    imageRight: viewModel.isPasswordEdit ? Constants.cancelIcon : Constants.editIcon,
                    gradientColors: viewModel.isPasswordEdit
                    ? [.redGradient, .orangeGradient]
                    : [.purpleGradient, .blueGradient]
                )
            )
        }
    }
}

