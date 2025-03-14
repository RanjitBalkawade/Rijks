//
//  ArtGetService.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 22/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation

protocol ArtGetServiceProtocol {
    func getArt(with objectNumber: String) async throws -> ArtDetails
}

extension ArtGetService: ArtGetServiceProtocol {}

class ArtGetService: NetworkService, KeyEnabled, ComposablePath {
    typealias T = ArtDetails
    
    //MARK: - Private properties

    private var defaultQueryItems: [String: String] {
        ["key": self.key]
    }

    var session: URLSession
    var urlString: String
    
    init(session: URLSession, urlString: String) {
        self.session = session
        self.urlString = urlString
    }
    
    //MARK: - Internal methods
    
    func getArt(with objectNumber: String) async throws -> ArtDetails {
        
        guard let url = self.urlRequestWithPathComponents(urlString: self.urlString, pathComponents: [objectNumber]) else {
            throw DataResponseError.invalidURLRequest
        }
        
        let urlRequest = URLRequest(url: url).encode(with: self.defaultQueryItems)
        return try await self.execute(urlRequest: urlRequest)
    }
}

