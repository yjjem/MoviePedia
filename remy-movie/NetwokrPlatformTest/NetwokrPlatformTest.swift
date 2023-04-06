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
    
    // MARK: Load Test Cases
    
    func test_서버_responseCode가_300일때_badResponse와_code를_올바르게_반환하는지() throws {
        
        // Arrange
        
        let dummyURL = try XCTUnwrap(URL(string: "test.com"))
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
        
        wait(for: [loadExpectation], timeout: 2)
    }
    
    func test_request_생성_실패시_requestFailed_오류를_반환하는지() throws {
        
        // Arrange
        
        let dummyURL = try XCTUnwrap(URL(string: "test.com"))
        
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: "fail request", code: 0)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "load")
        let errorExpectation = expectation(description: "request failure")
        
        sut.load(url: dummyURL, method: .get) { response in
            
            loadExpectation.fulfill()
            
            if case .failure(.requestFailed) = response {
                errorExpectation.fulfill()
            } else {
                XCTFail("not expected: \(response)")
            }
        }
        
        wait(for: [loadExpectation, errorExpectation], timeout: 2)
    }
    
    func test_response_200일시_success와_데이터를_반환하는지() throws {
        
        // Arrange
        
        let dummyURL = try XCTUnwrap(URL(string: "test.com"))
        let dummyData = Data()
        let dummyResponse = HTTPURLResponse(
            url: dummyURL,
            statusCode: 200,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (dummyData, try XCTUnwrap(dummyResponse))
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "load")
        let successExpectation = expectation(description: "load succeed")
        
        sut.load(url: dummyURL, method: .get) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(data) = response {
                successExpectation.fulfill()
                XCTAssertNotNil(data)
            } else {
                XCTFail("not expected: \(response)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)
    }
    
    // MARK: Upload Test Cases
    
    func test_성공적으로_upload시_에러반환을_안하는지() throws {
        
        // Arrange
        
        let dummyURL = try XCTUnwrap(URL(string: "test.com"))
        let dummyData = Data()
        let dummyResponse = HTTPURLResponse(
            url: dummyURL,
            statusCode: 200,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (nil, try XCTUnwrap(dummyResponse))
            
        }
        
        // Act and Assert
        
        let didCatchNoError = expectation(description: "upload error")
        didCatchNoError.isInverted = true
        
        sut.upload(data: dummyData, url: dummyURL, method: .post) { error in
            didCatchNoError.fulfill()
        }
        
        wait(for: [didCatchNoError], timeout: 2)
    }
    
    func test_upload_responseCode가_300일시_badResponse를_반환하는지() throws {
        
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
        
        let didCatchError = expectation(description: "uploadError")
        let expectedResponseCode = 300
        
        sut.upload(data: dummyData, url: dummyURL, method: .post) { error in
            
            didCatchError.fulfill()
            
            if case let .badResponse(code) = error {
                XCTAssertEqual(code, expectedResponseCode)
            }
        }
        
        wait(for: [didCatchError], timeout: 2)
    }
}