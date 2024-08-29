//
//  ExportContainer.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/11/24.
//

import SwiftUI

struct ExporterButton<IMSCollection: Collection>: View {
    @State private var isPresented: Bool = false

    private let title: String
    private let fileName: String
    private let collection: IMSCollection
    
    init(title: String,
         fileName: String,
         collection: IMSCollection) {
        self.title = title
        self.fileName = fileName
        self.collection = collection
    }
    
    var body: some View {
        Button(title) {
            isPresented.toggle()
        }
        .buttonStyle(
            GradientButtonStyle(imageLeft: "square.and.arrow.up.fill")
        )
        .fileExporter<IMSDocument>(
            isPresented: $isPresented,
            document: formattedDocument,
            contentType: .commaSeparatedText,
            defaultFilename: fileName) { result in
                switch result {
                    case .success(let success):
                        debugPrint("Saved on: \(success.description)")
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                }
            }
    }
    
    // MARK: - Formatted Document
    
    private var formattedDocument: IMSDocument {
        if let users = collection as? [UserModel] {
            IMSDocument(text: FileFactory.makeUserStringFormatted(users: users))
        } else if let histories = collection as? [InvoiceModel] {
            IMSDocument(text: FileFactory.makeHistoryStringFormatted(histories: histories))
        } else {
            IMSDocument(text: "Nothing")
        }
    }
}
