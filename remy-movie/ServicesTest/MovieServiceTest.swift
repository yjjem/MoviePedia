//
//  MovieServiceTest.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


@testable import remy_movie
import XCTest

final class MovieServiceTest: XCTestCase {
    
    var sut: MovieService?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguration)
        let manager = NetworkManager(session: session)
        sut = MovieService(manger: manager)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    // MARK: Test Cases
    
    func test_loadMovie실행_decoding실패시_오류_반환하는지()  throws {
        
        // Arrange
        
        let url = try XCTUnwrap(URL(string: "host.com"))
        let stubData = "stub data".data(using: .utf8)
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, try XCTUnwrap(stubResponse))
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let failExpectation = expectation(description: "did fail")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            loadExpectation.fulfill()
            
            if case let .failure(.decodeFailed(error)) = response {
                
                failExpectation.fulfill()
                
                printErrorWithDetailsOfFunction(name: #function, error: error)
            }
        }
        
        wait(for: [loadExpectation, failExpectation], timeout: 2)
    }
}
