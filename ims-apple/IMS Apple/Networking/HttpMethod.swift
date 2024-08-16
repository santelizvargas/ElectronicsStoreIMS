//
//  HttpMethod.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/12/24.
//

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

enum IMSPath {
    case login
    
    private var apiVersion: String { "/api/v1/" }
    
    var endPoint: String {
        var path: String {
            switch self {
                case .login: "auth/login"
            }
        }
        return "\(apiVersion)\(path)/"
    }
}
