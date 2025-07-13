//
//  ArtDetailsViewModelTests.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 12/08/2024.
//

import XCTest
@testable import RijksMuseum

final class ArtDetailsViewModelTests: XCTestCase {
    
    var viewModel: ArtDetailsViewModel!
    var mockService: MockArtGetService!
    
    override func setUp() {
        super.setUp()
        mockService = MockArtGetService()
        viewModel = ArtDetailsViewModel(service: mockService, objectNumber: "someObjectNumber")
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testArtDetailsViewModel_InitialViewStateIsLoading() {
        XCTAssertEqual(viewModel.viewState, .loading)
    }
    
    func testArtDetailsViewModel_LoadDataSuccess() async {
        // Given
        
        let expectedArtDetails = ArtFixtures.getArtDetails()
        
        mockService.artDetailsHandler = { _ in
            expectedArtDetails
        }
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .success)
        XCTAssertEqual(viewModel.description, expectedArtDetails.artObject?.description)
        XCTAssertEqual(viewModel.imageUrl, expectedArtDetails.artObject?.webImage?.url)
    }
    
    func testArtDetailsViewModel_LoadDataFailure() async {
        // Given
        mockService.getArtShouldReturnError = true
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .failure)
    }
    
    func testArtDetailsViewModel_DescriptionWhenArtObjectIsNil() async {
        // Given
        mockService.getArtShouldReturnError = true
        // When
        await viewModel.loadData()
        // Then
        XCTAssertEqual(viewModel.description, "-")
    }
    
    func testArtDetailsViewModel_ImageUrlWhenArtObjectIsNil() async {
        // Given
        mockService.getArtShouldReturnError = true
        // When
        await viewModel.loadData()
        // Then
        XCTAssertNil(viewModel.imageUrl)
    }
    
}
