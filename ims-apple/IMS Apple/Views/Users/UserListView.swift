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
            
            Button("Invitar Usuario") { }
                .buttonStyle(GradientButtonStyle(imageLeft: "paperplane.fill"))
            
            ExporterButton(title: "Exportar",
                           collection: UserModel.mockUsers)
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
                        ProfileImage(fullName: user.name)
                        
                        Text(user.name)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    userPropertyTextView(text: user.email)
                        
                    VStack {
                        ForEach(user.role, id: \.self) { role in
                            userPropertyTextView(text: role)
                        }
                    }
                        
                    userPropertyTextView(text: user.date)
                }
            }
        }
    }
    
    private func userPropertyTextView(text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.graySecundary)
    }
}

#Preview {
    UserListView()
}
