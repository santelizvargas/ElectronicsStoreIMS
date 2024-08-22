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
        LazyVGrid(columns: columns) {
            Group {
                Text("Usuario")
                Text("Email")
                Text("Rol")
                Text("Fecha")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    // MARK: - User List View
    
    private var userListView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.users) { user in
                    let shortName = getShortName(names: user.firstName, lastName: user.lastName)
                    
                    HStack {
                        ProfileImage(fullName: shortName)
                        
                        Text(shortName)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    userPropertyTextView(text: user.email)
                    
                    if user.roles.isEmpty {
                        Text("-")
                    } else {
                        ForEach(user.roles) { rol in
                            VStack {
                                userPropertyTextView(text: rol.name)
                            }
                        }
                    }
                    
                    if let updatedAt = user.updatedAt {
                        userPropertyTextView(text: updatedAt.dayMonthYear)
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
