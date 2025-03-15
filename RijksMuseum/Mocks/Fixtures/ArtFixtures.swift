//
//  ArtFixtures.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 11/08/2024.
//

import Foundation
@testable import RijksMuseum

class ArtFixtures {
    
    static let art = ArtObject(
        links: Links(linksSelf: "link", web: "web"),
        id: "id",
        objectNumber: "1",
        title: "abc",
        hasImage: true,
        longTitle: "longTitle",
        webImage: Image(guid: "123", url: "url"),
        headerImage: Image(guid: "123", url: "url"),
        techniques: ["technique1", "technique2"],
        description: "decription"
    )
    
    static func getArtCollection() -> ArtCollection {
        ArtCollection(artObjects: [Self.art])
    }
    
    static func getArtDetails() -> ArtDetails {
        ArtDetails(artObject: Self.art)
    }
}
