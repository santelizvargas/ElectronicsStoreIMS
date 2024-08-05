//
//  ProfileImage.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 4/8/24.
//

import SwiftUI

struct ProfileImage: View {
    private let url: String
    private let size: CGFloat
    
    init(url: String, size: CGFloat = 40) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .frame(width: size, height: size)
        } placeholder: {
            Circle()
                .fill(.graySecundary)
                .frame(width: size)
                .overlay(Image(systemName: "person.fill"))
        }
    }
}

#Preview {
    ProfileImage(url: "")
}
