//
//  Resolver+Injection.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        // Providers
        registerProviders()
        
        // Services
        registerServices()
    }
}

