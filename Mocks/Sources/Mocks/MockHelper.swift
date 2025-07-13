//
//  ViewLayoutMock.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 12/07/25.
//

import Foundation

public final class MockHelper {
    
    //MARK: - Public methods
    
    public static func loadMockData<T: Decodable>(
        from filename: String,
        as type: T.Type,
        bundle: Bundle
    ) -> T? {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            print("Failed to locate \(filename).json in bundle \(bundle).")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to decode \(filename).json: \(error)")
            return nil
        }
    }
}
