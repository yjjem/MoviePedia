//
//  MockURLProtocol.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (Data?, URLResponse))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let requestHandler = MockURLProtocol.requestHandler else {
            fatalError("FatalError: missing request handler")
        }
        
        do {
            let (data, response) = try requestHandler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            } else {
                let emptyDataError = NSError(domain: "emptyData", code: 1)
                client?.urlProtocol(self, didFailWithError: emptyDataError)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() { }
}
