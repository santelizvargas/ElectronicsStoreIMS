//
//  UserListView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 30/7/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 12
    static let columnsNumber: Int = 4
    static let mainSpacing: CGFloat = 20
}

struct UserListView: View {
    @ObservedObject private var viewModel: UserListViewModel = .init()
    @State private var isPresented: Bool = false
    
    private let columns: [GridItem] = Array(repeating: GridItem(), count: Constants.columnsNumber)
    
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            headerView
            
            VStack {
                headerListView
                
                Divider()
                
                userListView
            }
            .padding()
            .background(.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            
            Spacer()
        }
        .padding(Constants.mainSpacing)
        .background(.grayBackground)
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            Text("Usuarios Registrados")
            
            Spacer()
            
            Button("Agregar Usuario") {
                withAnimation {
                    isPresented.toggle()
                }
            }
            .buttonStyle(GradientButtonStyle(imageLeft: "paperplane.fill"))
            .isOS(.iOS) { view in
                view.popover(isPresented: $isPresented) {
                    RegisterUserView(isReloadUsers: $viewModel.isReloadUsers)
                        .presentationCompactAdaptation(.popover)
                }
            }
            .isOS(.macOS) { view in
                view.sheet(isPresented: $isPresented) {
                    RegisterUserView(isReloadUsers: $viewModel.isReloadUsers)
                }
            }
            
            ExporterButton(title: "Exportar", fileName: "Usuarios",
                           collection: viewModel.users)
        }
    }
    
    // MARK: - Header List View
    
    private var headerListView: some View {
        Grid {
            GridRow {
                Group {
                    Text("Usuario")
                    Text("Email")
                    Text("Rol")
                    Text("Fecha")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    // MARK: - User List View
    
    private var userListView: some View {
        ScrollView(showsIndicators: false) {
            Grid {
                ForEach(viewModel.users) { user in
                    let shortName = getShortName(names: user.firstName, lastName: user.lastName)
                    
                    GridRow {
                        HStack {
                            ProfileImage(fullName: shortName, isActive: user.deletedAt == nil)
                            
                            Text(shortName)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .foregroundStyle(user.deletedAt == nil ? .imsWhite : .imsGraySecundary)
                        }
                        
                        userPropertyTextView(text: user.email)
                        
                        if user.roles.isEmpty {
                            userPropertyTextView(text: "-")
                        } else {
                            if let rol = user.roles.first {
                                userPropertyTextView(text: rol.name)
                            }
                        }
                        
                        HStack {
                            userPropertyTextView(text: user.updatedAt.dayMonthYear)
                            
                            enableAndDisableButton(for: user.id, isEnable: user.deletedAt == nil)
                        }
                    }
                }
            }
        }
        .refreshable {
            viewModel.getUsers()
        }
        .overlay {
            if viewModel.isRequestInProgress {
                CustomProgressView()
            }
        }
    }
    
    // MARK: - Enable Disable Button
    
    private func enableAndDisableButton(for userId: Int, isEnable: Bool) -> some View {
        Menu {
            if isEnable {
                Button("Desactivar usuario") {
                    viewModel.disableUser(for: userId)
                }
            } else {
                Button("Activar usuario") {
                    viewModel.enableUser(for: userId)
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.imsWhite)
                .contentShape(Rectangle())
        }
        .menuStyle(.borderlessButton)
        .menuIndicator(.hidden)
        .frame(width: Constants.mainSpacing)
    }
    
    private func userPropertyTextView(text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.graySecundary)
    }
    
    private func getShortName(names: String, lastName: String) -> String {
        let names = names.components(separatedBy: " ")
        let lastName = lastName.components(separatedBy: " ")
        return "\(names.first ?? "") \(lastName.first ?? "")".capitalized
    }
}

#Preview {
    UserListView()
}
