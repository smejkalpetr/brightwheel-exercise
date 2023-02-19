//
//  TopRepositoriesView.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import SwiftUI
import Foundation

struct TopRepositoriesView: View {
    
    @ObservedObject var viewModel: TopRepositoriesViewModel
    
    var body: some View {
        VStack {
            title
            repositories
            Spacer()
        }
        .onAppear {
            viewModel.fetchRepositories()
        }
        .alert("Couldn't fetch GitHub Repositories.", isPresented: $viewModel.state.isShowingAlert) {
            Button("OK", role: .cancel) { viewModel.state.isShowingAlert = false }
        }
    }
    
    private var title: some View {
        Text("Repositories")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
    
    @ViewBuilder
    private var repositories: some View {
        if viewModel.state.isLoading {
            ProgressView()
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    Group {
                        Text("Name".uppercased())
                        Text("Top Contributor".uppercased())
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                    ForEach(viewModel.state.repositories) { repository in
                        VStack {
                            Text(repository.name)
                            Text(String(repository.starCount))
                        }
                        Text(repository.topContributor ?? "None")
                    }
                    .padding()
                }
            }
        }
    }
}

struct TopRepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        TopRepositoriesView(viewModel: TopRepositoriesViewModel())
    }
}
