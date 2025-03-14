//
//  Screens.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import Foundation

enum AppPages: Hashable {
    case main
    case articleDetails(id: String)
}

enum Sheet: String, Identifiable {
    case moreInfo
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case buy
    
    var id: String {
        self.rawValue
    }
}
