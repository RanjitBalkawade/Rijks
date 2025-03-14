//
//  URLRequest+extension.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 21/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation

extension URLRequest {
    func encode(with parameters: [String: String]?) -> URLRequest {
        guard
            let parameters = parameters,
            parameters.isEmpty == false,
            let url = self.url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return self
        }
        
        var encodedURLRequest = self
        
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = queryItems
        encodedURLRequest.url = urlComponents.url
        return encodedURLRequest
    }
}
