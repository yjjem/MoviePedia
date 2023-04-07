//
//  NetwokrPlatformTest.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.

@testable import remy_movie
import XCTest

final class NetwokrPlatformTest: XCTestCase {
    
    private var sut: NetworkManager!
    
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
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let data = Data()
        let expectedStatusCode = 300
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: expectedStatusCode,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (data, try XCTUnwrap(stubResponse))
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "load")
        
        let _ = sut.load(url: url, method: .get) { response in
            
            loadExpectation.fulfill()
            
            if case let .failure(error) = response,
               case let .badResponse(code) = error {
                XCTAssertEqual(code, expectedStatusCode)
            } else {
                XCTFail("not expected: \(response)")
            }
        }
        
        wait(for: [loadExpectation], timeout: 2)
    }
    
    func test_request_생성_실패시_requestFailed_오류를_반환하는지() throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: "fail request", code: 0)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "load")
        let errorExpectation = expectation(description: "request failure")
        
        let _ = sut.load(url: url, method: .get) { response in
            
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
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let stubData = Data()
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, try XCTUnwrap(stubResponse))
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "load")
        let successExpectation = expectation(description: "load succeed")
        
        let _ = sut.load(url: url, method: .get) { response in
            
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
    
    func test_load_올바르지_않은_response를_받으면_notHTTPURLResponse_에러를_반환하는지() throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let data = Data()
        let stubResponse = URLResponse(
            url: url,
            mimeType: "text/plain",
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (data, stubResponse)
        }
        
        // Act and Assert
        
        let didCatchErrorExpectation = expectation(description: "catch error")
        let requestFailedExpectation = expectation(description: "request failed")
        
        let _ = sut.load(url: url, method: .get) { error in
            
            didCatchErrorExpectation.fulfill()
            
            if case .failure(.notHTTPURLResponse) = error {
                requestFailedExpectation.fulfill()
            }
        }
        
        wait(for: [didCatchErrorExpectation, requestFailedExpectation], timeout: 2)
    }
    
    // MARK: Upload Test Cases
    
    func test_성공적으로_upload시_에러반환을_안하는지() throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let data = Data()
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (data, try XCTUnwrap(stubResponse))
        }
        
        // Act and Assert
        
        let didCatchNoError = expectation(description: "upload error")
        didCatchNoError.isInverted = true
        
        let _ = sut.upload(data: data, url: url, method: .post) { error in
            didCatchNoError.fulfill()
            XCTFail("unexpected error: \(error.debugDescription)")
        }
        
        wait(for: [didCatchNoError], timeout: 2)
    }
    
    func test_upload_responseCode가_300일시_badResponse를_반환하는지() throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let expectedStatusCode = 300
        let data = Data()
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: expectedStatusCode,
            httpVersion: "2.0",
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (nil, try XCTUnwrap(stubResponse))
        }
        
        // Act and Assert
        
        let didCatchError = expectation(description: "uploadError")

        let _ = sut.upload(data: data, url: url, method: .post) { error in
            
            didCatchError.fulfill()
            
            if case let .badResponse(code) = error {
                XCTAssertEqual(code, expectedStatusCode)
            }
        }
        
        wait(for: [didCatchError], timeout: 2)
    }
    
    func test_upload_requestFaild시_에러를_올바르게_반환하는지() throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: "fail request", code: 0)
        }
        
        // Act and Assert
        
        let didCatchErrorExpectation = expectation(description: "catch error")
        let requestFailedExpectation = expectation(description: "request failed")
        
        let _ = sut.upload(data: data, url: url, method: .post) { error in
            
            didCatchErrorExpectation.fulfill()
            
            if case .requestFailed = error {
                requestFailedExpectation.fulfill()
            }
        }
        
        wait(for: [didCatchErrorExpectation, requestFailedExpectation], timeout: 2)
    }
    
    func test_upload_올바르지_않은_response를_받으면_notHTTPURLResponse_에러를_반환하는지() throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "test.com"))
        let data = Data()
        let stubResponse = URLResponse(
            url: url,
            mimeType: "text/plain",
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (data, stubResponse)
        }
        
        // Act and Assert
        
        let didCatchErrorExpectation = expectation(description: "catch error")
        let requestFailedExpectation = expectation(description: "request failed")
        
        let _ = sut.upload(data: data, url: url, method: .post) { error in
            
            didCatchErrorExpectation.fulfill()
            
            if case .notHTTPURLResponse = error {
                requestFailedExpectation.fulfill()
            }
        }
        
        wait(for: [didCatchErrorExpectation, requestFailedExpectation], timeout: 2)
    }
}
