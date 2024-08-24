//
//  IMSBackground.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/27/24.
//

import SwiftUI

struct IMSBackground: View {
    var body: some View {
        ZStack {
            Color.imsPrimary
            
            GeometryReader { reader in
                let size: CGSize = reader.size
                
                BlurCircle(color: .imsSecondary, position: .topTrailing(size))
                BlurCircle(color: .imsSecondary, position: .bottomLeading(size))
                BlurCircle(color: .imsPurple, position: .bottomTrailing(size))
            }
        }
    }
}

#Preview {
    IMSBackground()
}
