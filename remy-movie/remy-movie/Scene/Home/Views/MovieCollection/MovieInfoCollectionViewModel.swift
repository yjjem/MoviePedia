//
//  MovieInfoCollectionViewModel.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


typealias MovieList = [Movie]
typealias VideoList = [Video]

protocol MovieInfoCollectionDelegate {
    func didLoadMovieList(list: MovieList, of category: ListCategory)
}

final class MovieInfoCollectionViewModel {
    
    var delegate: MovieInfoCollectionDelegate?
    
    private let useCase: MovieInfoUseCaseType
    
    init(useCase: MovieInfoUseCaseType) {
        self.useCase = useCase
    }
    
    // MARK: Function(s)
    
    func loadAllMovieLists() {
        
        let categories: [ListCategory] = [.popular, .upcoming, .nowPlaying, .topRated]
        let pageToLoad: Int = 1
        
        for category in categories {
            useCase.loadMovieList(page: pageToLoad, of: category) { response in
                if case let .success(item) = response,
                   let item {
                    self.delegate?.didLoadMovieList(list: item, of: category)
                }
            }
        }
    }
}
