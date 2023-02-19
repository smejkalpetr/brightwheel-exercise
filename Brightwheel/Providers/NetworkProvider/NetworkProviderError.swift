//
//  NetworkProviderError.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

public enum NetworkProviderError: Error {
    case requestFailed(statusCode: NetworkStatusCode, message: String)
}
