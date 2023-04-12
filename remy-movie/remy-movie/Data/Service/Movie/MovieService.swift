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
    
    // MARK: Function(s)
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<MovieList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let endPoint = makeEndPoint(path: .movieList(category), queryItems: [.page: String(page)])
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: MovieList.self)
            completion(decodeResult)
        }
    }
    
    func loadReviewList(
        page: Int,
        movieId: Int,
        completion: @escaping (Result<ReviewList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let endPoint = makeEndPoint(path: .reviewList(movieId), queryItems: [.page: String(page)])
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: ReviewList.self)
            completion(decodeResult)
        }
    }
    
    func loadVideoList(
        movieId: Int,
        completion: @escaping (Result<VideoList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let endPoint = makeEndPoint(path: .videoList(movieId), queryItems: nil)
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: VideoList.self)
            completion(decodeResult)
        }
    }
    
    func loadKeywordList(
        movieId: Int,
        completion: @escaping (Result<KeywordList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let endPoint = makeEndPoint(path: .keywordList(movieId), queryItems: nil)
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: KeywordList.self)
            completion(decodeResult)
        }
    }
    
    func loadProviderList(
        movieId: Int,
        completion: @escaping (Result<ProviderList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let endPoint: EndPoint = makeEndPoint(path: .providerList(movieId), queryItems: nil)
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: ProviderList.self)
            completion(decodeResult)
        }
    }
    
    func loadSimilarMovieList(
        page: Int,
        movieId: Int,
        completion: @escaping (Result<MovieList, NetworkError>?) -> Void
    ) -> URLSessionDataTask? {
        
        let endPoint = makeEndPoint(
            path: .similarMovieList(movieId),
            queryItems: [.page: String(page)]
        )
        
        return manager.load(url: endPoint.url, method: .get) { [weak self] response in
            let decodeResult = self?.tryDecodeAndValidate(response: response, as: MovieList.self)
            completion(decodeResult)
        }
    }
    
    // MARK: Private Function(s)
    
    private func makeEndPoint(path: Path, queryItems: [EndPoint.QueryKey: String]?) -> EndPoint {
        
        var queries = queryItems ?? [:]
        queries[.apiKey] = MainBundle.apiKey
        
        return EndPoint(
            host: TmdbAPIDetails.defaultHost,
            path: path.fullPath,
            queryItems: queries
        )
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

extension MovieService {
    enum Path {
        case movieList(ListCategory)
        case reviewList(Int)
        case videoList(Int)
        case keywordList(Int)
        case providerList(Int)
        case similarMovieList(Int)
        
        var fullPath: String {
            let mainPath = TmdbAPIDetails.defaultPath
            
            switch self {
            case .movieList(let category): return mainPath + category.path
            case .reviewList(let id): return mainPath + "/\(id)/reviews"
            case .videoList(let id): return mainPath + "/\(id)/videos"
            case .keywordList(let id): return mainPath  + "/\(id)/keywords"
            case .providerList(let id): return mainPath  + "/\(id)/watch/providers"
            case .similarMovieList(let id): return mainPath + "/\(id)/similar"
            }
        }
    }
}
