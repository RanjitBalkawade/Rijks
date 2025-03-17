//
//  ArtDetailsViewModel.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import Foundation

@Observable
class ArtDetailsViewModel {
    
    enum ViewState {
        case success
        case failure
        case loading
    }
    
    //MARK: - Internal properties
    
    var title: String {
        "Article"
    }
    
    var description: String {
        self.artObject?.description ?? "-"
    }
    
    var imageUrl: String? {
        self.artObject?.webImage?.url
    }
    
    private(set) var viewState: ViewState = .loading
    
    //MARK: - Private properties
    
    @ObservationIgnored
    private var artObject: ArtObject?
    
    private let service: ArtGetServiceProtocol
    private let objectNumber: String
    
    //MARK: - Initializer

    init(service: ArtGetServiceProtocol, objectNumber: String) {
        self.service = service
        self.objectNumber = objectNumber
    }
    
    //MARK: - Internal methods
    
    @MainActor
    func loadData() async {
        self.viewState = .loading
        do {
            let artDetails = try await self.service.getArt(with: self.objectNumber)
            self.artObject = artDetails.artObject
            self.viewState = .success
        } catch {
            self.viewState = .failure
        }
    }
    
}
