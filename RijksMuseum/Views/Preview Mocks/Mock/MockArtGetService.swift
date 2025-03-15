//
//  MockArtGetService.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 11/08/2024.
//

import Foundation
@testable import RijksMuseum

class MockArtGetService: ArtGetServiceProtocol {
    
    private(set) var getArtCallCount = 0
    var artDetailsHandler: ((String) -> ArtDetails)?
    var getArtShouldReturnError = false
    
    func getArt(with objectNumber: String) async throws -> ArtDetails {
        getArtCallCount += 1
        
        guard getArtShouldReturnError == false else {
            throw MockError.generalError
        }
        
        guard let artDetailsHandler = artDetailsHandler  else {
            fatalError()
        }
        return artDetailsHandler(objectNumber)
    }
    
}
