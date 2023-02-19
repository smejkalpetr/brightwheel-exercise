//
//  Services+Injection.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Resolver

extension Resolver {
    
    static func registerServices() {
        register { GitHubServiceImpl(networkProvider: resolve()) as GitHubService }
    }
}
