//
//  MovieServiceInterface.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

protocol MovieServiceInterface {
    typealias MovieList = GenericList<Movie>
    typealias ReviewList = GenericList<Review>
    typealias VideoList = GenericList<Video>
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<MovieList, NetworkError>?) -> Void
    ) -> URLSessionDataTask?
    
    func loadReviewList(
        movieId: Int,
        completion: @escaping (Result<ReviewList, NetworkError>?) -> Void
    ) -> URLSessionDataTask?
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<VideoList, NetworkError>?) -> Void
    ) -> URLSessionDataTask?
    
    func loadProvidersInfo(
        movieId: Int,
        completion: @escaping (Result<ProvidersInfo, NetworkError>?) -> Void
    ) -> URLSessionDataTask?
}

enum ListCategory {
    case popular
    case topRated
    case nowPlaying
    case upcoming
    
    var path: String {
        switch self {
        case .popular: return "popular"
        case .topRated:  return "top_rated"
        case .nowPlaying:  return "now_playing"
        case .upcoming:  return "upcoming"
        }
    }
}
