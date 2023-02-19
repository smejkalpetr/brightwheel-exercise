//
//  TopRepositoriesViewModel.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import SwiftUI
import Resolver

class TopRepositoriesViewModel: ObservableObject {
    
    @Published var state = State()
    
    @Injected var gitHubService: GitHubService
    
    struct State {
        var isLoading = false
        var repositories: [Repository] = []
        var isShowingAlert = false
    }
    
    @MainActor
    func fetchRepositories() {
        Task {
            defer { state.isLoading = false }
            do {
                state.isLoading = true
                state.repositories = try await gitHubService.getTopHundredWithTopContributor()
            } catch {
                state.isShowingAlert = true
            }
        }
    }
}
