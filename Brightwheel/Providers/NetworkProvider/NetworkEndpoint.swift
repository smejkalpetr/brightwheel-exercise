//
//  NetworkEndpoint.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Foundation

public protocol NetworkEndpoint {
    var baseURL: URL { get }

    var path: String { get }

    var method: NetworkMethod { get }
    
    var headers: [String: String]? { get }
    
    var queries: [URLQueryItem]? { get }
}
