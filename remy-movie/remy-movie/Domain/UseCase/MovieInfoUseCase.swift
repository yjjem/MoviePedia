//
//  MovieInfoUseCase.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


protocol MovieInfoUseCaseType {
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    )
    
    func loadDailyTrending(
        page: Int,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    )
}

final class MovieInfoUseCase: MovieInfoUseCaseType {
    
    private let service: MovieServiceInterface?
    
    init(service: MovieServiceInterface?) {
        self.service = service
    }
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<[Movie]?, NetworkError>) -> Void
    ) {
        service?.loadMovieList(page: page, of: category, completion: completion)
    }
    
    func loadDailyTrending(
        page: Int,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    ) {
        service?.loadDailyTrending(page: page, completion: completion)
    }
}
