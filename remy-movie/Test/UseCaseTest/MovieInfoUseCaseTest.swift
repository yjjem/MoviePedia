//
//  MovieInfoUseCaseTest.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    
@testable import remy_movie
import XCTest

final class MovieInfoUseCaseTest: XCTestCase {
    
    var sut: MovieInfoUseCaseType?
    var mockMovieService: MockMovieService?

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockMovieService = MockMovieService()
        sut = MovieInfoUseCase(service: mockMovieService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    
    func test_loadMovieList_정상작동_확인() {
        
        // Arrange
        
        let expectedCallCount: Int = 1
        let page: Int = 12
        let category: ListCategory = .popular
        
        // Act and Assert
        
        sut?.loadMovieList(page: page, of: category) { _ in }
        
        mockMovieService?.verityLoadMovieList(
            callCount: expectedCallCount,
            page: page,
            category: category
        )
    }
}
