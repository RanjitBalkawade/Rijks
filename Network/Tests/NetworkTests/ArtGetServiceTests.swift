//
//  ArtGetServiceTests.swift
//  RijksMuseumTests
//
//  Created by Ranjeet Balkawade on 23/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import XCTest
@testable import Mocks
@testable import Network
@testable import Models

final class ArtGetServiceTests: XCTestCase {

    var sut: ArtGetService!
    let urlString = "https://www.haha.com"

    override func setUp() {
        super.setUp()
        self.sut = ArtGetService(
            session: MockURLProtocol.getSessionWithMockURLProtocol(),
            urlString: self.urlString
        )
    }

    override func tearDown() {
        self.sut = nil
        let store = MockURLProtocolStore.shared
        store.stubResponseData = nil
        store.error = nil
        store.response = nil
        super.tearDown()
    }

    func testArtGetService_whenGivenSuccessfulResponse_ShouldReturnSuccess() async throws {
        // Arrange
        let store = MockURLProtocolStore.shared
        store.stubResponseData = """
        {
            "artObject": {
                "objectNumber": "abc",
                "id": "001",
                "title": "Art Piece"
            }
        }
        """.data(using: .utf8)

        store.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Act
        let artDetails = try await self.sut.getArt(with: "abc")

        // Assert
        XCTAssertEqual(artDetails.artObject?.objectNumber, "abc", "Should return expected object number")
    }

    func testArtGetService_WhenJsonDecodingFails_shouldReturnDecodingError() async {
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
            _ = try await self.sut.getArt(with: "")
            XCTFail("Expected decoding error")
        } catch {
            // Assert
            XCTAssertEqual(error as? DataResponseError, .decoding)
        }
    }

    func testArtGetService_whenNetworkErrorOccurs_shouldReturnNetworkError() async {
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
            _ = try await self.sut.getArt(with: "")
            XCTFail("Expected error due to HTTP 400")
        } catch {
            // Assert
            XCTAssertTrue(true, "Caught expected error")
        }
    }

    func testArtGetService_WhenInvalidUrlStringGiven_ShouldReturnInvalidUrlRequestError() async {
        // Arrange
        let sut = ArtGetService(
            session: MockURLProtocol.getSessionWithMockURLProtocol(),
            urlString: ""
        )

        // Act
        do {
            _ = try await sut.getArt(with: "")
            XCTFail("Expected invalid URL error")
        } catch {
            // Assert
            XCTAssertEqual(error as? DataResponseError, .invalidURLRequest)
        }
    }

    func testArtGetService_networkError() async {
        // Arrange
        let sut = ArtGetService(
            session: MockURLProtocol.getSessionWithMockURLProtocol(),
            urlString: ""
        )

        // Act
        do {
            _ = try await sut.getArt(with: "")
            XCTFail("Expected network error due to bad URL")
        } catch {
            // Assert
            XCTAssertEqual(error as? DataResponseError, .invalidURLRequest)
        }
    }
}
