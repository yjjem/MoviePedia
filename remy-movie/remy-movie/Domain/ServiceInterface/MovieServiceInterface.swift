//
//  MovieServiceInterface.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

protocol MovieServiceInterface {
    
    // MARK: Type(s)
    
    typealias MovieList = GenericResponse<[Movie]>
    typealias VideoList = GenericResponse<[Video]>
    
    // MARK: Function(s)
    
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

enum ListCategory {
    case popular
    case topRated
    case nowPlaying
    case upcoming
    
    var path: String {
        switch self {
        case .popular: return "/popular"
        case .topRated:  return "/top_rated"
        case .nowPlaying:  return "/now_playing"
        case .upcoming:  return "/upcoming"
        }
    }
}
