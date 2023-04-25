//
//  MockMovieService.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


@testable import remy_movie
import XCTest

final class MockMovieService: MovieServiceInterface {

    var loadMovieListCallCount: Int = 0
    var loadMovieListPage: Int?
    var loadMovieListCategory: ListCategory?
    
    var loadVideoListCallCount: Int = 0
    var loadVideoListMovieId: Int?
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<[Movie]?, NetworkError>) -> Void
    ) {
        loadMovieListCallCount += 1
        loadMovieListPage = page
        loadMovieListCategory = category
    }
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<[Video]?, NetworkError>) -> Void
    ) {
        loadVideoListCallCount += 1
        loadVideoListMovieId = movieId
    }
    
    func verityLoadMovieList(
        callCount: Int,
        page: Int,
        category: ListCategory,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(loadMovieListCallCount, 1, "call count", file: file, line: line)
        XCTAssertEqual(loadMovieListPage, page, "page", file: file, line: line)
        XCTAssertEqual(loadMovieListCategory, category, "page", file: file, line: line)
    }
    
    func verifyLoadVideoList(
        callCount: Int,
        movieId: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(loadVideoListCallCount, 1, "call count", file: file, line: line)
        XCTAssertEqual(loadVideoListMovieId, movieId, "movie id", file: file, line: line)
    }
}
