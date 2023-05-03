//
//  MovieService.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class MovieService: MovieServiceInterface {
    
    private var tasks: [URLSessionTask] = []
    private let manager: Networkable
    
    init(manger: Networkable) {
        self.manager = manger
    }
    
    deinit {
        tasks.forEach {
            $0.cancel()
        }
    }
    
    // MARK: Function(s)
    
    func loadMovieList(
        page: Int,
        of category: ListCategory,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    ) {
        
        let endPoint = makeEndPoint(path: .movieList(category), queryItems: [.page: String(page)])
        
        let task = manager.load(url: endPoint.url, method: .get) { [weak self] response in
            guard let self = self else { return }
            let decodeResult = self.tryDecodeAndValidate(response: response, as: MovieListResponse.self)
            completion(decodeResult.map { $0.asMovieList() })
        }
        
        if let task {
            tasks.append(task)
        }
    }
    
    func loadTrending(
        page: Int,
        category type: TrendingType,
        completion: @escaping (Result<MovieList?, NetworkError>) -> Void
    ) {
        
        let endPoint = makeEndPoint(path: .trending(type), queryItems: [.page: String(page)])
        
        let task = manager.load(url: endPoint.url, method: .get) { [weak self] response in
            guard let self = self else { return }
            let decodeResult = self.tryDecodeAndValidate(response: response, as: MovieListResponse.self)
            completion(decodeResult.map { $0.asMovieList() })
        }
        
        if let task {
            tasks.append(task)
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
        case trending(TrendingType)
        
        var fullPath: String {
            let mainPath = TmdbAPIDetails.defaultPath
            let trendingPath = TmdbAPIDetails.trendingMoviePath
            
            switch self {
            case .movieList(let category): return mainPath + category.path
            case .trending(let type): return trendingPath + type.path
            }
        }
    }
}
