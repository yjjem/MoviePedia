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
        of category: ListCategory,
        completion: @escaping (Result<MovieList, Error>?) -> Void
    ) -> URLSessionDataTask?
    
    func loadReviewList(
        movieId: Int,
        completion: @escaping (Result<ReviewList, Error>?) -> Void
    ) -> URLSessionDataTask?
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<VideoList, Error>?) -> Void
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
