//
//  MockURLProtocol.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 12/07/25.
//

import Foundation

// MARK: - Thread-safe shared test data access
public final class MockURLProtocolStore: @unchecked Sendable {
    
    //MARK: - Public properties
    
    public static let shared = MockURLProtocolStore()
    
    public var stubResponseData: Data? {
        get { queue.sync { _stubResponseData } }
        set { queue.sync { _stubResponseData = newValue } }
    }
    
    public var response: HTTPURLResponse? {
        get { queue.sync { _response } }
        set { queue.sync { _response = newValue } }
    }
    
    public var error: Error? {
        get { queue.sync { _error } }
        set { queue.sync { _error = newValue } }
    }
    
    //MARK: - Private properties
    
    private let queue = DispatchQueue(label: "com.paywall.tests.MockURLProtocolStore")
    private var _stubResponseData: Data?
    private var _response: HTTPURLResponse?
    private var _error: Error?
    
    //MARK: - Internal methods
    
    func snapshot() -> (data: Data?, response: HTTPURLResponse?, error: Error?) {
        return queue.sync { (_stubResponseData, _response, _error) }
    }
}

public final class MockURLProtocol: URLProtocol, @unchecked Sendable {
    
    //MARK: - Public methods
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        let snapshot = MockURLProtocolStore.shared.snapshot()
        
        let client = self.client
        let proto = self
        let data = snapshot.data ?? Data()
        let resp = snapshot.response
        let err = snapshot.error
        
        DispatchQueue.main.async { [client, proto, data, resp, err] in
            if let response = resp {
                client?.urlProtocol(proto,
                                    didReceive: response,
                                    cacheStoragePolicy: .notAllowed)
            }
            
            if let error = err {
                client?.urlProtocol(proto, didFailWithError: error)
            } else {
                client?.urlProtocol(proto, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(proto)
        }
    }
    
    public override func stopLoading() {
        // no-op
    }
}

public extension MockURLProtocol {
    
    //MARK: - Public methods
    
    static func getSessionWithMockURLProtocol() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
}

