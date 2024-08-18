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
                     with parameters: [String: Any],
                     httpMethod: HttpMethod = .get) async throws -> Data {
        var components: URLComponents = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURLString
        components.path = path.endPoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url
        else { throw IMSError.badUrl }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if httpMethod != .get {
            request.httpBody = components.percentEncodedQuery?.data(using: .utf8)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200...299 ~= statusCode
            else { throw IMSError.somethingWrong }
            
            return data
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
}
