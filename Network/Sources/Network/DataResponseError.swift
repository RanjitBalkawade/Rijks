//
//  DataResponseError.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 14/03/2025.
//

import Foundation

public enum DataResponseError: Error {
    case network
    case decoding
    case noData
    case invalidURLRequest
}
