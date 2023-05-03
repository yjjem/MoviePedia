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
    var loadedDailyTrendingMovieList: ((MovieList) -> Void)?
    var loadedWeeklyTrendingMovieList: ((MovieList) -> Void)?
    
    init(useCase: MovieInfoUseCaseType) {
        self.useCase = useCase
    }
    
    // MARK: Function(s)
    
    func initialBind() {
        loadMovieList(of: category)
        loadDailyTrendingMovieList()
        loadWeeklyTrendingMovieList()
    }
    
    private func loadMovieList(of category: ListCategory) {
        
        useCase.loadMovieList(page: pageToLoad, of: category) { [weak self] response in
            
            if case let .success(item) = response,
               let item {
                self?.loadedCategoryMovieList?(item)
            }
        }
    }
    
    private func loadDailyTrendingMovieList() {
        
        useCase.loadDailyTrending(page: pageToLoad) { [weak self] response in
            if case let .success(item) = response,
               let item {
                self?.loadedDailyTrendingMovieList?(item)
            }
        }
    }
    
    private func loadWeeklyTrendingMovieList() {
        
        useCase.loadWeeklyTrending(page: pageToLoad) { [weak self] response in
            if case let .success(item) = response,
               let item {
                self?.loadedWeeklyTrendingMovieList?(item)
            }
        }
    }
}
