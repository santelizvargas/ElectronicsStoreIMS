//
//  TextDocument.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct IMSDocument: FileDocument {
    static var readableContentTypes: [UTType] = [
        .pdf,
        .commaSeparatedText
    ]

    private let content: String
    
    init(text: String) {
        self.content = text
    }
    
    init(configuration: ReadConfiguration) {
        if let data = configuration.file.regularFileContents {
            content = String(decoding: data, as: UTF8.self)
        } else {
            content = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(content.utf8))
    }
}
