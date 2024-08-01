//
//  UserRegistrationView.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 30/7/24.
//

import SwiftUI

struct UserModel: Hashable, Identifiable {
    var id = UUID()
    let image: String
    let name: String
    let email: String
    let rol: String
    let fecha: String
}

struct UserRegistrationView: View {
    private let columns: [GridItem] = Array(repeating: GridItem(), count: 4)
    private let mockUsers: [UserModel] = [
        UserModel(image: "image1.png", name: "Alice Smith", email: "alice.smith@example.com", rol: "Admin", fecha: "2024-01-01"),
        UserModel(image: "image2.png", name: "Bob Johnson", email: "bob.johnson@example.com", rol: "User", fecha: "2023-12-15"),
        UserModel(image: "image3.png", name: "Carol Williams", email: "carol.williams@example.com", rol: "Moderator", fecha: "2023-11-30"),
        UserModel(image: "image4.png", name: "David Brown", email: "david.brown@example.com", rol: "Admin", fecha: "2023-10-25"),
        UserModel(image: "image5.png", name: "Eve Davis", email: "eve.davis@example.com", rol: "User", fecha: "2023-09-10") ]
    
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
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
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
                .buttonStyle(GradientButtonStyle(icon: "paperplane.fill"))
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
                ForEach(mockUsers) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.image)) { image in
                            image
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .padding()
                        }
                        .background {
                            Circle()
                                .fill(.pink)
                        }
                        
                        Text(user.name)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                    Group {
                        Text(user.email)
                        Text(user.rol)
                        Text(user.fecha)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.graySecundary)
                }
            }
        }
    }
}

#Preview {
    UserRegistrationView()
}
