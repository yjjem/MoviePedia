//
//  NetwokrPlatformTest.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.

@testable
import remy_movie
import XCTest

final class NetwokrPlatformTest: XCTestCase {
    
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguration)
        
        sut = NetworkManager(session: session)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    // MARK: Test Cases
    
    func test_서버_responseCode가_300일때_badResponse와_code를_올바르게_반환하는지() throws {
        
        // Arrange
        
        let dummyURL = try XCTUnwrap(URL(string: "test.com"))
        let dummyData = Data()
        let dummyResponse = HTTPURLResponse(
            url: dummyURL,
            statusCode: 300,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (nil, try XCTUnwrap(dummyResponse))
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "load")
        let expectedCode = 300
        
        sut.load(url: dummyURL, method: .get) { response in
            
            loadExpectation.fulfill()
            
            if case let .failure(error) = response,
               case let .badResponse(code) = error {
                XCTAssertEqual(code, expectedCode)
            } else {
                XCTFail("not expected: \(response)")
            }
        }
        
        wait(for: [loadExpectation], timeout: 5)
    }
}
