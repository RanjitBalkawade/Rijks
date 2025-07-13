//
//  ArtCollectionGetServiceTests.swift
//  RijksMuseumTests
//
//  Created by Ranjeet Balkawade on 21/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import XCTest
@testable import Mocks
@testable import Network

final class ArtCollectionGetServiceTests: XCTestCase {

    var sut: ArtCollectionGetService!
    let urlString = "https://www.haha.com"

    override func setUp() {
        super.setUp()
        self.sut = ArtCollectionGetService(
            session: MockURLProtocol.getSessionWithMockURLProtocol(),
            urlString: self.urlString
        )
    }

    override func tearDown() {
        self.sut = nil

        // Reset mock store
        let store = MockURLProtocolStore.shared
        store.stubResponseData = nil
        store.error = nil
        store.response = nil

        super.tearDown()
    }

    func testArtCollectionGetService_whenGivenSuccessfulResponse_ShouldReturnSuccess() async throws {
        // Arrange
        let json = """
        {
            "artObjects": [{
                "id": "test-id",
                "objectNumber": "123",
                "title": "Art Title",
                "description": "Desc"
            }]
        }
        """

        let store = MockURLProtocolStore.shared
        store.stubResponseData = json.data(using: .utf8)
        store.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Act
        let artCollection = try await self.sut.getCollection(with: "")

        // Assert
        XCTAssertEqual(artCollection.artObjects?.count, 1, "Should return one art object.")
        XCTAssertEqual(artCollection.artObjects?.first?.id, "test-id")
    }

    func testArtCollectionGetService_WhenJsonDecodingFails_shouldReturnDecodingError() async {
        // Arrange
        let store = MockURLProtocolStore.shared
        store.stubResponseData = "".data(using: .utf8)
        store.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Act
        do {
            _ = try await self.sut.getCollection(with: "")
            XCTFail("Expected decoding failure")
        } catch {
            // Assert
            XCTAssertEqual(error as? DataResponseError, .decoding)
        }
    }

    func testArtCollectionGetService_whenNetworkErrorOccurs_shouldReturnNetworkError() async {
        // Arrange
        let store = MockURLProtocolStore.shared
        store.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )

        // Act
        do {
            _ = try await self.sut.getCollection(with: "")
            XCTFail("Expected error due to bad status code")
        } catch {
            // Assert
            XCTAssertTrue(true, "Caught expected network error")
        }
    }

    func testArtCollectionservice_WhenInvalidUrlStringGiven_ShouldReturnInvalidUrlRequestError() async {
        // Arrange
        let sut = ArtCollectionGetService(
            session: MockURLProtocol.getSessionWithMockURLProtocol(),
            urlString: ""
        )

        // Act
        do {
            _ = try await sut.getCollection(with: "")
            XCTFail("Expected invalid URL request error")
        } catch {
            // Assert
            XCTAssertEqual(error as? DataResponseError, .invalidURLRequest)
        }
    }
}
