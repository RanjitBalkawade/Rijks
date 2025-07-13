//
//  MainViewModel.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import Foundation
import Models
import Network

@Observable
class MainViewModel {
    
    enum MainViewState {
        case success
        case failure
        case loading
    }
    
    //MARK: - Internal properties
    
    var title: String {
        "Articles"
    }
    
    var viewState: MainViewState = .loading
    
    @ObservationIgnored
    private(set) var collectionThumbnailViewModels: [ArtCollectionThumbnailViewModel] = []
    
    //MARK: - Private properties
    
    @ObservationIgnored
    private var artObjects = [ArtObject]() {
        didSet {
            collectionThumbnailViewModels = artObjects.map { ArtCollectionThumbnailViewModel(article: $0) }
        }
    }
    
    private let service: ArtCollectionGetServiceProtocol
    
    //MARK: - Initialiser
    
    init(service: ArtCollectionGetServiceProtocol) {
        self.service = service
    }
    
    //MARK: - Internal methods
    
    @MainActor
    func loadData(with query: String) async {
        viewState = .loading
                
        do {
            let artCollection = try await self.service.getCollection(with: query)
            self.artObjects = artCollection.artObjects ?? []
            viewState = .success
        }
        catch {
            viewState = .failure
        }
    }
    
}
