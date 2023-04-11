//
//  MovieService.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class MovieService: MovieServiceInterface {
    
    private let manager: Networkable
    
    init(manger: Networkable) {
        self.manager = manger
    }
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<MovieList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "page", value: String(page))]
        let endPoint: EndPoint = EndPoint(
            host: "https://api.themoviedb.org",
            path: "/3/movie/\(category.path)",
            queryItems: queryItems
        )
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: MovieList.self)
            completion(decodeResult)
        }
    }
    
    func loadReviewList(
        movieId: Int,
        completion: @escaping (Result<ReviewList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        // TODO: Change
        
        let endPoint: EndPoint = EndPoint(
            host: "https://api.themoviedb.org",
            path: "/3/movie/\(movieId)/reviews",
            queryItems: nil
        )
        
        print(endPoint.url)
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: ReviewList.self)
            completion(decodeResult)
        }
    }
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<VideoList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        // TODO: Change
        
        let endPoint: EndPoint = EndPoint(
            host: "host.com",
            path: "/3/movie/\(movieId)/videos",
            queryItems: nil
        )
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: VideoList.self)
            completion(decodeResult)
        }
    }
    
    func loadProvidersInfo(
        movieId: Int,
        completion: @escaping (Result<ProvidersInfo, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        // TODO: Change
        
        let endPoint: EndPoint = EndPoint(
            host: "host.com",
            path: "/3/movie/\(movieId)/watch/providers",
            queryItems: nil
        )
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: ProvidersInfo.self)
            completion(decodeResult)
        }
    }
    
    private func tryDecodeAndValidate<T: Decodable>(
        response: Result<Data, NetworkError>,
        as type: T.Type
    ) -> Result<T, NetworkError> {
        
        switch response {
        case .success(let data):
            return data.tryDecode(as: type)
        case .failure(let error):
            return .failure(error)
        }
    }
}
