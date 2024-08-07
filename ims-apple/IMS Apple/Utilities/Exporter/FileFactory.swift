//
//  FileFactory.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/7/24.
//

import Foundation

final class FileFactory {
    
    func makeUserStringFormatted(users: [UserModel]) -> String {
        let header: String = "Name, Email, Role, Date"
        
        let mappedUsers: String = users.map { user in
            "\"\(user.name)\", \"\(user.email)\", \"\(user.role)\", \"\(user.date)\""
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedUsers].joined(separator: "\n")
        return stringFormatted
    }
    
}
