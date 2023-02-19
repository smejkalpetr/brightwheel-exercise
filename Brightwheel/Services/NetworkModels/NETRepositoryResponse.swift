//
//  NETRepositoryResponse.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 19.02.2023.
//

struct NETRepositoryResponse: Codable {
    let items: [NETRepository]
}

struct NETRepository: Codable, Hashable {
    let id: Int
    let name: String
    let owner: Owner
    let stargazers_count: Int
    var topContributor: String?
    
    struct Owner: Codable, Hashable {
        let login: String
    }
}

extension NETRepository {
    var domainModel: Repository {
        Repository(
            id: id,
            name: name,
            owner: owner.login,
            starCount: stargazers_count,
            topContributor: topContributor
        )
    }
}
