//
//  GitHubService.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Foundation

public protocol GitHubService {
    func getTopHundredWithTopContributor() async throws -> [Repository]
}

public struct GitHubServiceImpl: GitHubService {
    
    private let networkProvider: NetworkProvider
    
    public init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    public func getTopHundredWithTopContributor() async throws -> [Repository] {
        let repositories = try await getTopHundredRepositories()
        let repoContributor = try await getTopContributors(for: repositories)
        
        return repoContributor.map {
            var finalRepository = $0
            finalRepository.topContributor = $1?.login
            return finalRepository.domainModel
        } .sorted { $0.starCount > $1.starCount }
    }
    
    private func getTopHundredRepositories() async throws -> [NETRepository] {
        let endpoint = GitHubAPI.getTop100
        
        let data = try await networkProvider.request(endpoint)
        let responseModel = try JSONDecoder().decode(NETRepositoryResponse.self, from: data)
        
        return responseModel.items
    }
    
    private func getTopContributors(for repositories: [NETRepository]) async throws -> [NETRepository: NETUser?] {
        let repoContributor = try await repositories.asyncReduce([NETRepository: NETUser?]()) { partialResult, repository in
            let endpoint = GitHubAPI.getTopContributor(owner: repository.owner.login, repositoryName: repository.name)
            
            let data = try await networkProvider.request(endpoint)
            let contributor = try JSONDecoder().decode([NETUser].self, from: data)
            
            var dict = partialResult
            dict[repository] = contributor.first
            return dict
        }
        
        return repoContributor
    }
}

public extension Sequence {
    func asyncReduce<Result>(
        _ initialResult: Result,
        _ nextPartialResult: ((Result, Element) async throws -> Result)
    ) async rethrows -> Result {
        var result = initialResult
        for element in self {
            result = try await nextPartialResult(result, element)
        }
        return result
    }
}
