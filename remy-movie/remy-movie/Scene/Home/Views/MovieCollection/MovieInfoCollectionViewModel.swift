//
//  MovieInfoCollectionViewModel.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.

import Foundation

typealias MovieList = [Movie]
typealias VideoList = [Video]

final class MovieInfoCollectionViewModel {
    
    private let useCase: MovieInfoUseCaseType
    
    var category: ListCategory = .popular {
        didSet {
            loadMovieList(of: category)
        }
    }
    
    let pageToLoad: Int = 1
    var loadedCategoryMovieList: ((MovieList) -> Void)?
    var loadedTrendingMovieList: ((MovieList) -> Void)?
    
    init(useCase: MovieInfoUseCaseType) {
        self.useCase = useCase
    }
    
    // MARK: Function(s)
    
    func initialBind() {
        loadMovieList(of: category)
        loadTrendingMovieList()
    }
    
    private func loadMovieList(of category: ListCategory) {
        
        useCase.loadMovieList(page: pageToLoad, of: category) { [weak self] response in
            
            if case let .success(item) = response,
               let item {
                self?.loadedCategoryMovieList?(item)
            }
        }
    }
    
    private func loadTrendingMovieList() {
        
        useCase.loadDailyTrending(page: pageToLoad) { [weak self] response in
            if case let .success(item) = response,
               let item {
                self?.loadedTrendingMovieList?(item)
            }
        }
    }
}
