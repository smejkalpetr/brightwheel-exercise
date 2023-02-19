//
//  Repository.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Foundation

public struct Repository: Codable, Identifiable {
    public let id: Int
    let name: String
    let owner: String
    let starCount: Int
    let topContributor: String?
}
