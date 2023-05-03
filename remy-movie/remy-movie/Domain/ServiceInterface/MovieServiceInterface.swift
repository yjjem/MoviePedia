//
//  MovieServiceInterface.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


protocol MovieServiceInterface {
    
    // MARK: Type(s)
    
    typealias MovieListResponse = GenericResponse<[Movie]>
    
    // MARK: Function(s)
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    )
    
    func loadTrending(
        page: Int,
        category type: TrendingType,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    )
}

extension ListCategory {
    var path: String {
        switch self {
        case .popular: return "/popular"
        case .topRated:  return "/top_rated"
        case .nowPlaying:  return "/now_playing"
        case .upcoming:  return "/upcoming"
        }
    }
}

enum TrendingType {
    case daily
    case weekly
    
    var path: String {
        switch self {
        case .daily: return "/day"
        case .weekly: return "/week"
        }
    }
}
