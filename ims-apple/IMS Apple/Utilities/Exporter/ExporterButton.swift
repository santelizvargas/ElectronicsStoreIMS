//
//  ExportContainer.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/11/24.
//

import SwiftUI

struct ExporterButton<IMSCollection: Collection>: View {
    @State private var isPresented: Bool = false

    private let collection: IMSCollection
    private let title: String
    
    init(title: String,
         collection: IMSCollection) {
        self.title = title
        self.collection = collection
    }
    
    var body: some View {
        Button(title) {
            isPresented.toggle()
        }
        .buttonStyle(GradientButtonStyle(imageLeft: "square.and.arrow.up.fill"))
        .fileExporter<IMSDocument>(
            isPresented: $isPresented,
            documents: [formattedDocument],
            contentType: .commaSeparatedText) { result in
            switch result {
                case .success(let success):
                    print("Saved on: \(success.description)")
                case .failure(let error):
                    fatalError(error.localizedDescription)
            }
        }
    }
    
    private var formattedDocument: IMSDocument {
        if let users = collection as? [UserModel] {
            IMSDocument(text: FileFactory.makeUserStringFormatted(users: users))
        } else if let histories = collection as? [HistoryModel] {
            IMSDocument(text: FileFactory.makeHistoryStringFormatted(histories: histories))
        } else {
            IMSDocument(text: "Nothing")
        }
    }
}
