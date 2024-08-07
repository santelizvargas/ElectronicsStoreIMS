//
//  PermissionHandler.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/5/24.
//

import Foundation
import AppKit

final class FileExporter {
    
    // MARK: - Properties
    
    private lazy var fileFactory: FileFactory = FileFactory()
    
    private lazy var savePanel: NSSavePanel = {
        let panel: NSSavePanel = .init()
        panel.directoryURL = getDownloadsDirectoryUrl()
        panel.prompt = "Save"
        return panel
    }()
    
    // MARK: - Functions
    
    private func getDownloadsDirectoryUrl() -> URL {
        FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
    }
    
    func exportUserList(from users: [UserModel]) -> Bool {
        
        savePanel.allowedContentTypes = [.commaSeparatedText]
        
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
