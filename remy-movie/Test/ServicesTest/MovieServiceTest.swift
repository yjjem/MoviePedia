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
    
    // MARK: Failure Cases
    
    func test_loadMovieList실행_decoding실패시_오류_반환하는지()  throws {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        let stubData = "stub data".data(using: .utf8)
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let failExpectation = expectation(description: "did fail")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            loadExpectation.fulfill()
            
            if case .failure(.decodeFailed) = response {
                failExpectation.fulfill()
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, failExpectation], timeout: 2)
    }
    
    func test_loadMovieList실행_networkManager_에러가_올바르게_들어오는지() throws {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        let stubData = Data()
        let expectedCode = 300
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: expectedCode,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let failExpectation = expectation(description: "did fail")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            
            loadExpectation.fulfill()
            
            if case let .failure(.badResponse(code)) = response {
                failExpectation.fulfill()
                XCTAssertEqual(expectedCode, code)
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, failExpectation], timeout: 2)
    }
    
    // MARK: Success Cases
    
    func test_loadMovieList_문제없을시_정상적으로_MovieList를_반환하는지() {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        
        let expectedPage = 1
        let expectedMovieCount = 1
        let expectedTitle = "Suicide Squad"
        
        let stubData = MovieServiceStubJsons.movieList
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadMovieList(page: 1, of: .popular) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(movieList) = response {
                successExpectation.fulfill()
                XCTAssertTrue(movieList.page == expectedPage)
                XCTAssertTrue(movieList.results?.count == expectedMovieCount)
                XCTAssertTrue(movieList.results?[0].originalTitle == expectedTitle)
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)
    }
    
    func test_loadReviewList_문제없을시_정상적으로_ReviewList를_반환하는지() {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        
        let expectedId = 11
        let expectedAuthor = "Cat Ellington"
        
        let stubData = MovieServiceStubJsons.reviewList
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadReviewList(page: 1, movieId: 11) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(reviewList) = response {
                successExpectation.fulfill()
                XCTAssertEqual(reviewList.id, expectedId)
                XCTAssertEqual(reviewList.results?[0].author, expectedAuthor)
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)
    }
    
    func test_loadVideoList_문제없을시_정상적으로_VideoList를_반환하는지() {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        
        let expectedId = 550
        let expectedVideoCount = 2
        
        let stubData = MovieServiceStubJsons.videoList
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadVideoList(movieId: 11) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(videoList) = response {
                successExpectation.fulfill()
                XCTAssertEqual(videoList.id, expectedId)
                XCTAssertEqual(videoList.results?.count, expectedVideoCount)
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)
    }
    
    func test_loadKeywordList_문제없을시_정상적으로_KeywordList를_반환하는지() {
        
        // Arrange
        
        let url = URL(string: "host.com")!
    
        let expectedKeywordCount = 1
        let expectedKeywordId = 825
        
        let stubData = MovieServiceStubJsons.keyworkdList
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadKeywordList(movieId: 550) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(keywordList) = response {
                successExpectation.fulfill()
                
                let keywordList = keywordList.keywords
                
                XCTAssertEqual(keywordList?.count, expectedKeywordCount)
                XCTAssertEqual(keywordList?[0].id, expectedKeywordId)
                
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)

    }
    
    func test_loadProviderList_문제없을시_정상적으로_ProviderList를_반환하는지() {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        
        let expectedFlatRateCount = 1
        let expectedBuyCount = 2
        
        let stubData = MovieServiceStubJsons.providersInfo
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadProviderList(movieId: 11) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(providersInfo) = response {
                successExpectation.fulfill()
                
                let krProviderInfo = providersInfo.results?.kr
                XCTAssertEqual(krProviderInfo?.flatrate?.count, expectedFlatRateCount)
                XCTAssertEqual(krProviderInfo?.buy?.count, expectedBuyCount)
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)
    }
    
    func test_loadSimilarMovieList_문제없으시_정상적으로_MovieList를_반환하는지() {
        
        // Arrange
        
        let url = URL(string: "host.com")!
        
        let expectedPage = 1
        let expectedMovieCount = 1
        let expectedTitle = "Suicide Squad"
        
        let stubData = MovieServiceStubJsons.movieList
        let stubResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubData, stubResponse!)
        }
        
        // Act and Assert
        
        let loadExpectation = expectation(description: "did load")
        let successExpectation = expectation(description: "did success")
        
        let _ = sut?.loadSimilarMovieList(page: 1, movieId: 297761) { response in
            
            loadExpectation.fulfill()
            
            if case let .success(movieList) = response {
                successExpectation.fulfill()
                XCTAssertTrue(movieList.page == expectedPage)
                XCTAssertTrue(movieList.results?.count == expectedMovieCount)
                XCTAssertTrue(movieList.results?[0].originalTitle == expectedTitle)
            } else {
                XCTFail("unexpected response: \(response.debugDescription)")
            }
        }
        
        wait(for: [loadExpectation, successExpectation], timeout: 2)
    }
}
