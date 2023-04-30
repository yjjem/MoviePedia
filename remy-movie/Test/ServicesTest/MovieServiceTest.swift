//
//  MovieServiceTest.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


@testable import remy_movie
import XCTest

final class MovieServiceTest: XCTestCase {
    
    private var sut: MovieService?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let manager = MockNetworkManager()
        sut = MovieService(manger: manager)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    // MARK: Failure Cases
    
    func test_loadMovieList실행_decoding실패시_오류_반환하는지()  throws {
        
        // Arrange
        
        let decodeFailError = NSError(domain: "invalid json", code: 1)
        let error: NetworkError = .decodeFailed(decodeFailError)
        let data: Data? = nil
        
        MockNetworkManager.mockHandler = {
            return (error, data)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let failExpectation = expectation(description: "did fail")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            loadExpectation.fulfill()
            
            if case .failure(.decodeFailed) = response {
                failExpectation.fulfill()
            } else {
                XCTFail("unexpected response: \(response)")
            }
        }
        
        wait(for: [loadExpectation, failExpectation], timeout: 2)
    }
    
    func test_loadMovieList실행_networkManager_에러가_올바르게_들어오는지() throws {
        
        // Arrange
        
        let data: Data? = nil
        let error: NetworkError = .notHTTPURLResponse
        
        MockNetworkManager.mockHandler = {
            return (error, data)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let failExpectation = expectation(description: "did fail")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            
            loadExpectation.fulfill()
            
            if case .failure(.notHTTPURLResponse) = response {
                failExpectation.fulfill()
            } else {
                XCTFail("unexpected response: \(response)")
            }
        }
        
        wait(for: [loadExpectation, failExpectation], timeout: 2)
    }
    
    // MARK: Success Cases
    
    func test_loadMovieList_문제없을시_정상적으로_MovieList를_반환하는지() {
        
        // Arrange
        
        let error: NetworkError? = nil
        let stubJsonData: Data = MovieServiceStubJsons.movieList!
        let expectedMovieCount = 1
        
        MockNetworkManager.mockHandler = {
            return (error, stubJsonData)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(movieList) = response {
                successExpectation.fulfill()
                XCTAssertTrue(movieList?.count == expectedMovieCount)
            } else {
                XCTFail("unexpected response: \(response)")
            }
        }
    }
}
