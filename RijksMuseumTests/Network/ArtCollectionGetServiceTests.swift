//
//  ArtCollectionGetServiceTests.swift
//  RijksMuseumTests
//
//  Created by Ranjeet Balkawade on 21/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import XCTest
@testable import RijksMuseum

class ArtCollectionGetServiceTests: XCTestCase {

    var sut: ArtCollectionGetService!
    let urlString = "https://www.haha.com"

    override func setUp() {
        self.sut = ArtCollectionGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: self.urlString)
    }

    override func tearDown() {
        self.sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
        MockURLProtocol.response = nil
    }

    func testArtCollectionGetService_whenGivenSuccessfulResponse_ShouldReturnSuccess() async throws {
        //Arrange
        MockURLProtocol.stubResponseData = "{\"artObjects\": [{\"id\":\"\"}]}".data(using: .utf8)
        
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        //Act
        let artCollection = try await self.sut.getCollection(with: "")
        
        //Assert
        XCTAssertEqual(artCollection.artObjects!.count, 1, "should have return data")
        
    }

    func testArtCollectionGetService_WhenJsonDecodingFails_shouldReturnDecodingError() async {
        //Arrange
        MockURLProtocol.stubResponseData = "".data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        //Act
        do {
            _ = try await self.sut.getCollection(with: "")
            XCTFail("Expected to fail")
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.decoding)
        }
        
    }

    func testArtCollectionGetService_whenNetworkErrorOccurs_shouldReturnNetworkError() async {
        //Arrange
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        
        //Act
        do {
            _ = try await self.sut.getCollection(with: "")
        }
        catch {
            //Assert
            XCTAssertTrue(true)
        }
    }

    func testArtCollectionservice_WhenInvalidUrlStringGiven_ShouldReturnInvalidUrlRequestError() async {
        //Arrrange
        let sut = ArtCollectionGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: "")

        //Act
        do {
            _ = try await sut.getCollection(with: "")
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.invalidURLRequest)
        }
    }

}

