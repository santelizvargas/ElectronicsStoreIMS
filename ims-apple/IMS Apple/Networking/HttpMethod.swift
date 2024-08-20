//
//  HttpMethod.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/12/24.
//

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

enum IMSPath {
    case login
    case getProducts
    case updatePassword
    case users
    
    private var apiVersion: String { "/api/v1/" }
    
    var endPoint: String {
        var path: String {
            switch self {
                case .login: "auth/login"
                case .getProducts: "products"
                case .updatePassword: "auth/password"
                case .users: "auth"
            }
        }
        return "\(apiVersion)\(path)/"
    }
}
