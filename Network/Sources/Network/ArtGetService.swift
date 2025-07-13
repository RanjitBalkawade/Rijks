//
//  ArtGetService.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 22/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation
import Models

public protocol ArtGetServiceProtocol {
    func getArt(with objectNumber: String) async throws -> ArtDetails
}

public class ArtGetService: NetworkService, KeyEnabled, ComposablePath, ArtGetServiceProtocol {
    public typealias T = ArtDetails
    
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
    
    public func getArt(with objectNumber: String) async throws -> ArtDetails {
        guard let url = self.urlRequestWithPathComponents(urlString: self.urlString, pathComponents: [objectNumber]) else {
            throw DataResponseError.invalidURLRequest
        }
        
        let urlRequest = URLRequest(url: url).encode(with: self.defaultQueryItems)
        return try await self.execute(urlRequest: urlRequest)
    }
}
