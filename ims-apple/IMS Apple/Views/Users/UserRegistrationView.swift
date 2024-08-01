//
//  UserRegistrationView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 30/7/24.
//

import SwiftUI

struct UserModel: Identifiable {
    var id = UUID()
    let image: String
    let name: String
    let email: String
    let role: String
    let date: String
}

extension UserModel {
    static let mockUsers: [UserModel] = [
        UserModel(image: "image1.png", name: "Alice Smith", email: "alice.smith@example.com", role: "Admin", date: "2024-01-01"),
        UserModel(image: "image2.png", name: "Bob Johnson", email: "bob.johnson@example.com", role: "User", date: "2023-12-15"),
        UserModel(image: "image3.png", name: "Carol Williams", email: "carol.williams@example.com", role: "Moderator", date: "2023-11-30"),
        UserModel(image: "image4.png", name: "David Brown", email: "david.brown@example.com", role: "Admin", date: "2023-10-25"),
        UserModel(image: "image5.png", name: "Eve Davis", email: "eve.davis@example.com", role: "User", date: "2023-09-10") ]
}

private enum Constant {
    static let cornerRadius: CGFloat = 12
    static let rowNumber: Int = 4
}

struct UserRegistrationView: View {
    private let columns: [GridItem] = Array(repeating: GridItem(), count: Constant.rowNumber)
    
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
