//
//  MainViewModelTests.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 11/08/2024.
//

import XCTest
@testable import RijksMuseum

class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    var service: MockArtCollectionGetService!
    
    override func setUp() {
        super.setUp()
        self.service = MockArtCollectionGetService()
        self.sut = MainViewModel(service: self.service)
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func testMainViewModel_InitialViewStateIsLoading() {
        XCTAssertEqual(sut.viewState, .loading)
    }
    
    func testMainViewModel_CollectionThumbnailViewModelsIsEmpty_WhenArtObjectsIsEmpty() {
        XCTAssertTrue(sut.collectionThumbnailViewModels.isEmpty)
    }
    
    func testMainViewModel_WhenLoadDataSucceeds_shouldReturnSuccessViewState() async {
        
        let expectedArtObjects = ArtFixtures.getArtCollection()
        self.service.artCollectionHandler = { _ in
            expectedArtObjects
        }
        XCTAssertEqual(sut.viewState, MainViewModel.MainViewState.loading)
        await sut.loadData(with: "")
        XCTAssertEqual(sut.viewState, MainViewModel.MainViewState.success)
        XCTAssertEqual(sut.collectionThumbnailViewModels.count, expectedArtObjects.artObjects?.count)
    }
    
    func testMainViewModel_WhenLoadingData_shouldReturnLoadingViewState() async {
        self.service.artCollectionHandler = { _ in
            XCTAssertEqual(self.sut.viewState, MainViewModel.MainViewState.loading)
            return ArtFixtures.getArtCollection()
        }
        await sut.loadData(with: "")
    }
    
    func testMainViewModel_WhenLoadgDataFails_shouldReturnFailureViewState() async {
        self.service.getCollectionShouldReturnError = true
        XCTAssertEqual(sut.viewState, MainViewModel.MainViewState.loading)
        await sut.loadData(with: "")
        XCTAssertEqual(sut.viewState, MainViewModel.MainViewState.failure)
        XCTAssertTrue(sut.collectionThumbnailViewModels.isEmpty)
    }
}
