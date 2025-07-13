//
//  Factory.swift
//  RaboAssignment
//
//  Created by Ranjeet Balkawade on 09/07/2024.
//

import Foundation
import Network

class Factory {
    
    static func createArtCollectionGetService() -> ArtCollectionGetServiceProtocol {
        ArtCollectionGetService(session: URLSession.shared, urlString: Configuration.API.baseUrl)
    }
    
    static func createArtGetService() -> ArtGetServiceProtocol {
        ArtGetService(session: URLSession.shared, urlString: Configuration.API.baseUrl)
    }
    
}
