//
//  ProfileImage.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 4/8/24.
//

import SwiftUI

private enum Constants {
    static let fontSize: CGFloat = 0.4
    static let defaultSize: CGFloat = 40
    static let namesPrefix: Int = 2
    static let mapPrefix: Int = 1
}

// MARK: - Profile Image View

struct ProfileImage: View {
    private let fullName: String
    private let size: CGFloat
    
    init(fullName: String, 
         size: CGFloat = Constants.defaultSize) {
        self.fullName = fullName
        self.size = size
    }
    
    var body: some View {
        Circle()
            .fill(.imsLightPurple)
            .frame(width: size)
            .overlay {
                Text(abbreviations)
                    .font(.system(size: size * Constants.fontSize))
                    .bold()
            }
    }
    
    private var abbreviations: String {
        fullName
            .split(separator: " ")
            .prefix(Constants.namesPrefix)
            .map { $0.prefix(Constants.mapPrefix) }
            .joined()
            .uppercased()
    }
}

#Preview {
    ProfileImage(fullName: "Juan Perez")
        .padding()
}
