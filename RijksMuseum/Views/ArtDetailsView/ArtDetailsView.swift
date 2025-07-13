//
//  ArtDetailsView.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import SwiftUI
import Kingfisher

struct ArtDetailsView: View {
    
    @Environment(Coordinator.self) private var coordinator
    var viewModel: ArtDetailsViewModel
    
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
                await viewModel.loadData()
            }
        }
    }
    
    var successView: some View {
        VStack {
            if let imageUrl = viewModel.imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFit()
            } else {
                Image(viewModel.placeHolderImageName)
                    .resizable()
                    .scaledToFit()
            }
            Text(viewModel.description)
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
    let mockService = MockArtGetService()
    mockService.artDetailsHandler = { _ in
        ArtFixtures.getArtDetails()
    }
    let viewModel = ArtDetailsViewModel(service: mockService, objectNumber: ArtFixtures.art.objectNumber!)
    return ArtDetailsView(viewModel: viewModel).environment(Coordinator())
}

#Preview("Failure") {
    let mockService = MockArtGetService()
    mockService.getArtShouldReturnError = true
    let viewModel = ArtDetailsViewModel(service: mockService, objectNumber: ArtFixtures.art.objectNumber!)
    return ArtDetailsView(viewModel: viewModel).environment(Coordinator())
}

