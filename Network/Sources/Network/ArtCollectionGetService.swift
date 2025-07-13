//
//  ArtCollectionGetService1.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 21/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation
import Models

public protocol ArtCollectionGetServiceProtocol {
    func getCollection(with query: String) async throws -> ArtCollection
}

public class ArtCollectionGetService: NetworkService, KeyEnabled, ArtCollectionGetServiceProtocol {
    
    public typealias T = ArtCollection
    
    // MARK: - Private properties

    private var defaultQueryItems: [String: String] {
        ["key": self.key]
    }
    
    public var session: URLSession
    public var urlString: String
    
    public init(session: URLSession, urlString: String) {
        self.session = session
        self.urlString = urlString
    }

    // MARK: - Public methods
    
    public func getCollection(with query: String) async throws -> ArtCollection {
        guard let urlRequest = self.getURLRequest(with: query) else {
            throw DataResponseError.invalidURLRequest
        }
        
        return try await self.execute(urlRequest: urlRequest)
    }

    // MARK: - Private methods

    private func getURLRequest(with query: String) -> URLRequest? {
        guard let url = URL(string: self.urlString) else {
            return nil
        }
        
        var queryItems = self.defaultQueryItems
        queryItems["q"] = query

        return URLRequest(url: url).encode(with: queryItems)
    }
}
