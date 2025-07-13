//
//  ComposablePath.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 14/03/2025.
//

import Foundation

protocol ComposablePath {
    func urlRequestWithPathComponents(urlString: String, pathComponents: [String]) -> URL?
}

extension ComposablePath {
    func urlRequestWithPathComponents(urlString: String, pathComponents: [String]) -> URL? {
        var url = URL(string: urlString)
        pathComponents.forEach { url?.appendPathComponent($0) }
        return url
    }
}
