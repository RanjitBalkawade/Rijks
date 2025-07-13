//
//  HTTPURLResponse+extension.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 14/03/2025.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= self.statusCode
    }
}
