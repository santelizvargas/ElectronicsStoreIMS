//
//  NetworkManager.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/12/24.
//

import Foundation

private enum Constants {
    static let scheme: String = "https"
    static let baseURLString: String = "ims-electronics.up.railway.app"
}

final class NetworkManager {
    private func makeQueryItems(parameters: [String: Any]) -> [URLQueryItem] {
        parameters.map { key, value in
            URLQueryItem(name: key, value: value as? String)
        }
    }
    
    func makeRequest(path: IMSPath,
                     with parameters: [String: Any]? = nil,
                     httpMethod: HttpMethod = .get) async throws -> Data {
        var components: URLComponents = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURLString
        components.path = path.endPoint
        
        if let parameters {
            components.queryItems = makeQueryItems(parameters: parameters)
            components.queryItems?.reverse()
        }
        
        guard let url = components.url
        else { throw IMSError.badUrl }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw IMSError.badRequest }
            
            switch statusCode {
                case 200...299: return data
                case 400...500: throw IMSError.wrongCredentials
                case 500...503: throw IMSError.internetConnection
                default: throw IMSError.badRequest
            }
        } catch {
            throw IMSError.badRequest
        }
    }
    
}

struct LoginResponse<Entity: Decodable>: Decodable {
    let accessToken: String?
    let expiresIn: Int?
    let data: Entity?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case expiresIn = "expiresIn"
        case data
    }
}

