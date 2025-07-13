//
//  ArtCollection.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/07/2025.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation

// MARK: - ArtCollection
public struct ArtCollection: Codable, Sendable {

    public let artObjects: [ArtObject]?

    public init(artObjects: [ArtObject]?) {
        self.artObjects = artObjects
    }
}

public struct ArtDetails: Codable, Sendable {
    public let artObject: ArtObject?

    public init(artObject: ArtObject?) {
        self.artObject = artObject
    }
}

// MARK: - ArtObject
public struct ArtObject: Codable, Sendable {
    public let links: Links?
    public let id, objectNumber, title, description: String?
    public let hasImage: Bool?
    public let longTitle: String?
    public let webImage, headerImage: ImageInfo?
    public let techniques: [String]?

    public init(links: Links?, id: String?, objectNumber: String?, title: String?, hasImage: Bool?, longTitle: String?, webImage: ImageInfo?, headerImage: ImageInfo?, techniques: [String]?, description: String?) {
        self.links = links
        self.id = id
        self.objectNumber = objectNumber
        self.title = title
        self.hasImage = hasImage
        self.longTitle = longTitle
        self.webImage = webImage
        self.headerImage = headerImage
        self.techniques = techniques
        self.description = description
    }
}

// MARK: - Image
public struct ImageInfo: Codable, Sendable {
    public let guid: String?
    public let url: String?

    public init(guid: String?, url: String?) {
        self.guid = guid
        self.url = url
    }
}

// MARK: - Links
public struct Links: Codable, Sendable {
    public let linksSelf, web: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case web
    }

    public init(linksSelf: String?, web: String?) {
        self.linksSelf = linksSelf
        self.web = web
    }
}
