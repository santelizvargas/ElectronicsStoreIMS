//
//  UserRegistrationView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 30/7/24.
//

import SwiftUI

private enum Constant {
    static let cornerRadius: CGFloat = 12
    static let columnsNumber: Int = 4
}

struct UserRegistrationView: View {
    private let columns: [GridItem] = Array(repeating: GridItem(), count: Constant.columnsNumber)
    
    var body: some View {
        VStack {
            headerView
            
            VStack {
                headerList
                
                Divider()
                
                userList
            }
            .padding()
            .background(.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: Constant.cornerRadius))
            
            Spacer()
        }
        .padding()
        .background(.grayBackground)
    }
    
    private var headerView: some View {
        HStack {
            Text("Usurios Registrados")
            
            Spacer()
            
            Button("Invitar Usuario") { }
                .buttonStyle(GradientButtonStyle(iconName: "paperplane.fill"))
        }
        .padding()
    }
    
    private var headerList: some View {
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
    
    private var userList: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(UserModel.mockUsers) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.image)) { image in
                            image
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.grayBackground)
                                .padding()
                        }
                        .background {
                            Circle()
                                .fill(.graySecundary)
                        }
                        
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
    UserRegistrationView()
}
