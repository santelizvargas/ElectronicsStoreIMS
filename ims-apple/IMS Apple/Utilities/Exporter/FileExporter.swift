//
//  PermissionHandler.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/5/24.
//

import Foundation
import AppKit
import UniformTypeIdentifiers

final class FileExporter {
    
    // MARK: - Properties
    
    private lazy var fileFactory: FileFactory = FileFactory()
    
    // MARK: - Functions
    
    private func getDownloadsDirectoryUrl() -> URL {
        FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
    }
    
    private func savePanel(type: UTType, fileName: String) -> NSSavePanel {
        let panel: NSSavePanel = NSSavePanel()
        panel.directoryURL = getDownloadsDirectoryUrl()
        panel.prompt = "Save"
        panel.allowedContentTypes = [type]
        panel.nameFieldStringValue = fileName
        return panel
    }
    
    func exportUserList(from users: [UserModel]) -> Bool {
        
        let savePanel: NSSavePanel = savePanel(type: .commaSeparatedText, fileName: "IMS Users")
        
        if savePanel.runModal() == .OK,
           let url = savePanel.url {
            
            let stringFormatted: String = fileFactory.makeUserStringFormatted(users: users)
            
            do {
                try stringFormatted.write(to: url, atomically: true, encoding: .utf8)
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    // TODO: Export PDF File
}
