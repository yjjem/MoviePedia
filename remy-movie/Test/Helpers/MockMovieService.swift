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
    
    var loadTrendingListCallCount: Int = 0
    var loadTrendingListPage: Int?
    var loadTrendingListCategory: TrendingType?
    
    var expectedError: NetworkError?
    
    let expectedMovie: Movie = .init(
        posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview: "From DC Comics...",
        releaseDate: "2016-08-03",
        genreIds: [14, 28, 80],
        id: 297761,
        originalTitle: "Suicide Squad",
        originalLanguage: "en",
        title: "Suicide Squad",
        backdropPath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: 48.261451,
        voteCount: 1466,
        video: false,
        voteAverage: 5.91
    )
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<[Movie]?, NetworkError>) -> Void
    ) {
        loadMovieListCallCount += 1
        loadMovieListPage = page
        loadMovieListCategory = category
        
        if let expectedError {
            completion(.failure(expectedError))
        } else {
            completion(.success([expectedMovie, expectedMovie]))
        }
    }
    
    func loadTrending(
        page: Int,
        category type: TrendingType,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    ) {
        loadTrendingListCallCount += 1
        loadTrendingListPage = page
        loadTrendingListCategory = category
        
        if let expectedError {
            completion(.failure(expectedError))
        } else {
            completion(.success([expectedMovie]))
        }
    }
    
    func verify(
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
}
