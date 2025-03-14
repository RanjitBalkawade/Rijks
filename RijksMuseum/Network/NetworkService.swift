//
//  GetService.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 23/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation

protocol NetworkService {
    associatedtype T: Codable
    
    var urlString: String { get set }
    var session: URLSession { get set }
    func execute(urlRequest: URLRequest) async throws -> T
}

extension NetworkService {
    func execute(urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: urlRequest)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.hasSuccessStatusCode else {
            throw DataResponseError.network
        }
        
        do {
            let modelData = try JSONDecoder().decode(T.self, from: data)
            return modelData
        }
        catch {
            throw DataResponseError.decoding
        }
    }
}
