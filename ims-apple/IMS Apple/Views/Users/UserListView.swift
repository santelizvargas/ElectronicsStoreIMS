//
//  UserListView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 30/7/24.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 12
    static let columnsNumber: Int = 4
    static let mainSpacing: CGFloat = 20
}

struct UserListView: View {
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
            
            Button("Invitar Usuario") { }
                .buttonStyle(GradientButtonStyle(imageLeft: "paperplane.fill"))
            
            #if os(macOS)
            Button("Exportar Lista") {
                FileExporter().exportUserList(from: UserModel.mockUsers)
            }
            .buttonStyle(GradientButtonStyle(imageLeft: "square.and.arrow.up.fill"))
            #endif
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
                ForEach(UserModel.mockUsers) { user in
                    HStack {
                        ProfileImage(url: user.image)
                        
                        Text(user.name)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    Group {
                        Text(user.email)
                        Text(user.role)
                        Text(user.date)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.graySecundary)
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
