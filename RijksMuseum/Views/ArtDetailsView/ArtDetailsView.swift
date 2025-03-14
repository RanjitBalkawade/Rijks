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
    @Bindable var viewModel: ArtDetailsViewModel
    
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
        .onAppear {
            Task {
                if viewModel.viewState != .success {
                    await viewModel.loadData()
                }
            }
        }
    }
    
    var successView: some View {
        VStack {
            if let imageUrl = viewModel.imageUrl {
                KFImage(URL(string: imageUrl))
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
