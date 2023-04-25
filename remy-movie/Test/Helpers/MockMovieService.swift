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
    let expectedMovie: Movie = .init(
        posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview: "From DC Comics...",
        releaseData: "2016-08-03",
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
    
    var loadVideoListCallCount: Int = 0
    var loadVideoListMovieId: Int?
    let expectedVideo: Video = .init(
        iso6391: "en",
        iso31661: "US",
        name: "Fight Club - Theatrical Trailer Remastered in HD",
        key: "6JnN1DmbqoU",
        size: 1080,
        type: "Trailer",
        official: false,
        publishedAt: "2015-02-26T03:19:25.000Z",
        id: "5e382d1b4ca676001453826d"
    )
    
    var expectedError: NetworkError?
    
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
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<[Video]?, NetworkError>) -> Void
    ) {
        loadVideoListCallCount += 1
        loadVideoListMovieId = movieId
        
        if let expectedError {
            completion(.failure(expectedError))
        } else {
            completion(.success([expectedVideo, expectedVideo]))
        }
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
