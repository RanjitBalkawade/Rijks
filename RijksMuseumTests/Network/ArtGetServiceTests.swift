//
//  ArtGetServiceTests.swift
//  RijksMuseumTests
//
//  Created by Ranjeet Balkawade on 23/09/2020.
//  Copyright © 2020 RanjeetBalkawade. All rights reserved.
//

import XCTest
@testable import RijksMuseum

class ArtGetServiceTests: XCTestCase {

    var sut: ArtGetService!
    let urlString = "https://www.haha.com"

    override func setUp() {
        self.sut = ArtGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: self.urlString)
    }

    override func tearDown() {
        self.sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
        MockURLProtocol.response = nil
    }
    
    func testArtGetService_whenGivenSuccessfulResponse_ShouldReturnSuccess() async throws {
        //Arrange
        MockURLProtocol.stubResponseData = "{\"artObject\": {\"objectNumber\":\"abc\"}}".data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        //Act
        let artDetails = try await self.sut.getArt(with: "")
        
        //Assert
        XCTAssertEqual(artDetails.artObject?.objectNumber, "abc", "should have return data")
    }

    func testArtGetService_WhenJsonDecodingFails_shouldReturnDecodingError() async {
        //Arrange
        MockURLProtocol.stubResponseData = "".data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        do {
            _ = try await self.sut.getArt(with: "")
        }
        catch {
            XCTAssertEqual(error as! DataResponseError, DataResponseError.decoding)
        }
    }

    func testArtGetService_whenNetworkErrorOccurs_shouldReturnNetworkError() async {
        //Arrange
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        
        //Act
        do {
            _ = try await self.sut.getArt(with: "")
        }
        catch {
            //Assert
            XCTAssertTrue(true)
        }
    }

    func testArtGetService_WhenInvalidUrlStringGiven_ShouldReturnInvalidUrlRequestError() async {
        //Arrrange
        let sut = ArtGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: "")

        //Act
        do {
            _ = try await sut.getArt(with: "")
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.invalidURLRequest)
        }
        
    }
    
    func testArtGetService_networkError() async {
        //Arrrange
        let sut = ArtGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: "")
        
        //Act
        do {
            _ = try await sut.getArt(with: "")
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.invalidURLRequest)
        }
        
    }

}
