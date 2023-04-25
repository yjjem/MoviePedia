//
//  MovieInfoUseCase.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

protocol MovieInfoUseCaseType {
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<[Movie]?, NetworkError>) -> Void
    )
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<[Video]?, NetworkError>) -> Void
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
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<[Video]?, NetworkError>) -> Void
    ) {
        service?.loadVideoList(movieId: movieId, completion: completion)
    }
}
