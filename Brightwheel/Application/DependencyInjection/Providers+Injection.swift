//
//  Providers+Injection.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Resolver

extension Resolver {
    
    static func registerProviders() {
        register { NetworkProviderImpl() as NetworkProvider }
    }
}
