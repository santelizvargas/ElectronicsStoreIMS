//
//  PermissionHandler.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/5/24.
//

import Foundation
import AppKit

final class PermissionHandler {
    
    private func getDownloadsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func writeFile(data: String) {
        let savePanel: NSSavePanel = .init()
        savePanel.directoryURL = self.getDownloadsDirectory()
        savePanel.prompt = "Save"
        savePanel.nameFieldStringValue = "Users"
        savePanel.allowedContentTypes = [.xml]
        savePanel.runModal()
        
        guard let url = savePanel.url else { return }
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
