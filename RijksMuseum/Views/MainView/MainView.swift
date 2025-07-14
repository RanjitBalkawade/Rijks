//
//  MainView.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import SwiftUI

struct MainView: View {
    
    @Environment(Coordinator.self) private var coordinator
    @State var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
                case .success:
                    successView
                case .failure:
                    failureView
                case .loading:
                    loadingView
            }
        }
        .navigationTitle(viewModel.title)
        .task {
            if viewModel.viewState != .success {
                await viewModel.loadData(with: Configuration.defaultQuery)
            }
        }
    }
    
    private var successView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.collectionThumbnailViewModels) { thumbnailVM in
                    ArtCollectionThumbnailView(viewModel: thumbnailVM)
                }
            }
            .padding()
        }
    }

    private var failureView: some View {
        Text("Failed to load data")
    }
    
    private var loadingView: some View {
        Text("Loading...")
    }
}

#Preview("Success") {
    let mockService = MockArtCollectionGetService()
    mockService.artCollectionHandler = { _ in
        ArtFixtures.getArtCollection()
    }
    let viewModel = MainViewModel(service: mockService)
    return MainView(viewModel: viewModel).environment(Coordinator())
}

#Preview("Failure") {
    let mockService = MockArtCollectionGetService()
    mockService.getCollectionShouldReturnError = true
    let viewModel = MainViewModel(service: mockService)
    return MainView(viewModel: viewModel).environment(Coordinator())
}
