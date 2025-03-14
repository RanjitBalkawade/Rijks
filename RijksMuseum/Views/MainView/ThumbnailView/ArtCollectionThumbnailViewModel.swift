//
//  CollectionThumbnailViewModel.swift
//  RijksMuseum1
//
//  Created by Ranjeet Balkawade on 22/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import Foundation

class ArtCollectionThumbnailViewModel: Identifiable {
 
    //MARK: - Internal properties

    let id = UUID().uuidString
    
    var title: String {
        self.artObject.title ?? ""
    }
    
    var buyButtonTitle: String {
        "Buy"
    }
    
    var moreInfoButtonTitle: String {
        "More Info"
    }

    var imageUrl: String? {
        self.artObject.webImage?.url
    }

    var objectNumber: String? {
        self.artObject.objectNumber
    }

    //MARK: - Private properties

    private let artObject: ArtObject

    //MARK: - Initializer

    init(article: ArtObject) {
        self.artObject = article
    }
    
}
