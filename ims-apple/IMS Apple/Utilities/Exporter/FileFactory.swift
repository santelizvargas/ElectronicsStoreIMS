//
//  FileFactory.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/7/24.
//

import Foundation

final class FileFactory {
    
    static func makeUserStringFormatted(users: [UserModel]) -> String {
        let header: String = "Nombre, Email, Rol, Fecha"
        
        let mappedUsers: String = users.map { user in
            "\(user.name), \(user.email), \(user.role), \(user.date)"
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedUsers].joined(separator: "\n")
        return stringFormatted
    }
    
    static func makeHistoryStringFormatted(histories: [HistoryModel]) -> String {
        let header: String = "Nombre, Telefono, Fecha"
        
        let mappedUsers: String = histories.map { history in
            "\(history.name), \(history.phoneNumber), \(history.date)"
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedUsers].joined(separator: "\n")
        return stringFormatted
    }
}
