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
        .onAppear {
            Task {
                if viewModel.viewState != .success {
                    await viewModel.loadData(with: Configuration.defaultQuery)
                }
            }
        }
    }
    
    private var successView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach((0..<viewModel.collectionThumbnailViewModels.count), id: \.self) { index in
                    ArtCollectionThumbnailView(viewModel: viewModel.collectionThumbnailViewModels[index])
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
