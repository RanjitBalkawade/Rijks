//
//  ArtCollectionThumbnailViewModelTests.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 12/08/2024.
//


import XCTest
@testable
import RijksMuseum

final class ArtCollectionThumbnailViewModelTests: XCTestCase {
    
    var sut: ArtCollectionThumbnailViewModel!
    var artObject: ArtObject!
    
    override func setUp() {
        super.setUp()
        artObject = ArtFixtures.art
        sut = ArtCollectionThumbnailViewModel(article: artObject)
    }
    
    override func tearDown() {
        sut = nil
        artObject = nil
        super.tearDown()
    }
    
    func testTitle() {
        XCTAssertEqual(sut.title, artObject.title)
    }
    
    func testImageUrl() {
        XCTAssertEqual(sut.imageUrl, artObject.webImage?.url)
    }

    
    func testObjectNumber() {
        XCTAssertEqual(sut.objectNumber, artObject.objectNumber)
    }
    
    func testIdIsGenerated() {
        XCTAssertNotNil(sut.id)
    }
}
