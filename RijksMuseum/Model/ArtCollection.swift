//
//  ArtCollection.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 21/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation

// MARK: - ArtCollection
class ArtCollection: Codable {

    let artObjects: [ArtObject]?

    init(artObjects: [ArtObject]?) {
        self.artObjects = artObjects
    }
}

class ArtDetails: Codable {
    let artObject: ArtObject?

    init(artObject: ArtObject?) {
        self.artObject = artObject
    }
}

// MARK: - ArtObject
class ArtObject: Codable {
    let links: Links?
    let id, objectNumber, title, description: String?
    let hasImage: Bool?
    let longTitle: String?
    let webImage, headerImage: Image?
    let techniques: [String]?

    init(links: Links?, id: String?, objectNumber: String?, title: String?, hasImage: Bool?, longTitle: String?, webImage: Image?, headerImage: Image?, techniques: [String]?, description: String?) {
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
class Image: Codable {
    let guid: String?
    let url: String?

    init(guid: String?, url: String?) {
        self.guid = guid
        self.url = url
    }
}

// MARK: - Links
class Links: Codable {
    let linksSelf, web: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case web
    }

    init(linksSelf: String?, web: String?) {
        self.linksSelf = linksSelf
        self.web = web
    }
}
