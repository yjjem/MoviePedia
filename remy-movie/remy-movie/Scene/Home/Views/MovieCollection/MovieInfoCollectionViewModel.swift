//
//  MovieInfoCollectionViewModel.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


final class MovieInfoCollectionViewModel {
    
    var category: ListCategory = .popular {
        didSet {
            loadMovieList(of: category)
        }
    }
    
    var loadedCategoryMovieList: (([MovieWrapper]) -> Void)?
    var loadedDailyTrendingMovieList: (([MovieWrapper]) -> Void)?
    var loadedWeeklyTrendingMovieList: (([MovieWrapper]) -> Void)?
    
    private let pageToLoad: Int = 1
    private let useCase: MovieInfoUseCaseType
    
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
                let categoryWrappedMovieList = item.map { MovieWrapper.category($0) }
                self?.loadedCategoryMovieList?(categoryWrappedMovieList)
            }
        }
    }
    
    private func loadDailyTrendingMovieList() {
        
        useCase.loadDailyTrending(page: pageToLoad) { [weak self] response in
            if case let .success(item) = response,
               let item {
                let dailyWrappedMovieList = item.map { MovieWrapper.daily($0) }
                self?.loadedDailyTrendingMovieList?(dailyWrappedMovieList)
            }
        }
    }
    
    private func loadWeeklyTrendingMovieList() {
        
        useCase.loadWeeklyTrending(page: pageToLoad) { [weak self] response in
            if case let .success(item) = response,
               let item {
                let weeklyWrappedMovieList = item.map { MovieWrapper.weekly($0) }
                self?.loadedWeeklyTrendingMovieList?(weeklyWrappedMovieList)
            }
        }
    }
}
