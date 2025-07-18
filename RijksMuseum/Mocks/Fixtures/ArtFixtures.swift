//
//  ArtFixtures.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 11/08/2024.
//

import Foundation
@testable import Models

class ArtFixtures {
    
    static let art = ArtObject(
        links: Links(linksSelf: "link", web: "web"),
        id: "id",
        objectNumber: "1",
        title: "abc",
        hasImage: true,
        longTitle: "longTitle",
        webImage: ImageInfo(guid: nil, url: nil),
        headerImage: ImageInfo(guid: nil, url: nil),
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
