//
//  MockArtCollectionGetService.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 11/08/2024.
//

import Foundation

enum MockError: Error {
    case generalError
}

class MockArtCollectionGetService: ArtCollectionGetServiceProtocol {
    
    private(set) var getCollectionCount = 0
    var artCollectionHandler: ((String) -> ArtCollection)?
    var loading: (() -> Void)?
    var getCollectionShouldReturnError = false
    
    func getCollection(with query: String) async throws -> ArtCollection {
        getCollectionCount += 1
        
        guard getCollectionShouldReturnError == false else {
            throw MockError.generalError
        }
        
        loading?()
        
        guard let artCollectionHandler = artCollectionHandler else {
            fatalError()
        }
        
        return artCollectionHandler(query)
    }
}
