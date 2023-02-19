//
//  NetworkProvider.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Foundation

public protocol NetworkProvider {
    func request(_ endpoint: NetworkEndpoint) async throws -> Data
}

struct NetworkProviderImpl: NetworkProvider {
    
    func request(_ endpoint: NetworkEndpoint) async throws -> Data {
        // Create URL
        let components = URLComponents(url: endpoint.baseURL, resolvingAgainstBaseURL: false)
        
        guard var components else {
            throw NetworkProviderError.requestFailed(statusCode: .unknown, message: NetworkingConstants.urlComposeErrorMessage)
        }
        
        components.path = endpoint.path
        if let queryItems = endpoint.queries {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw NetworkProviderError.requestFailed(statusCode: .unknown, message: NetworkingConstants.urlComposeErrorMessage)
        }
        
        NSLog("URL of request: \(url)")
        
        // Create request
        var request = URLRequest(url: url)
        
        // Assign HTTP method
        request.httpMethod = endpoint.method.rawValue
        
        // Add headers
        if let headers = endpoint.headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        // Add OAuth2 token
        request.addValue("Bearer \(NetworkingConstants.OAuth2Token)", forHTTPHeaderField: "Authorization")
        
        // Prepare request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Catch HTTP errors
        if let httpResponse = response as? HTTPURLResponse {
            if !(200...299).contains(httpResponse.statusCode) {
                throw NetworkProviderError.requestFailed(
                    statusCode: NetworkStatusCode(rawValue: httpResponse.statusCode) ?? .unknown,
                    message: String(data: data, encoding: .utf8) ?? ""
                )
            }
        }
        
        return data
    }
}
