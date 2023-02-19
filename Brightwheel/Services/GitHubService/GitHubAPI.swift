//
//  GitHubAPI.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import Foundation

enum GitHubAPI {
    case getTop100
    case getTopContributor(owner: String, repositoryName: String)
}

extension GitHubAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    
    var path: String {
        switch self {
        case .getTop100:
            return "/search/repositories"
        case let .getTopContributor(owner, repositoryName):
            return "/repos/\(owner)/\(repositoryName)/contributors"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .getTop100:
            return .get
        case .getTopContributor:
            return .get
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .getTop100:
            return [
                /*
                 "stars:>50000" is because of GitHub API limitations,
                 see https://stackoverflow.com/questions/56251307/get-the-top-10-javascript-opensource-repositories-ranked-by-star-using-github-gr
                 */
                URLQueryItem(name: "q", value: "stars:>50000"),
                URLQueryItem(name: "sort", value: "stars"),
                URLQueryItem(name: "order", value: "desc"),
                URLQueryItem(name: "per_page", value: "100")
            ]
        default:
            return nil
        }
    }
}
