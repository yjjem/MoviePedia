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
            bind()
        }
    }
    
    var handler: ((Output) -> Void)?
    
    init(useCase: MovieInfoUseCaseType) {
        self.useCase = useCase
    }
    
    // MARK: Function(s)
    
    func bind() {
        
        let pageToLoad: Int = 1
        
        self.useCase.loadMovieList(page: pageToLoad, of: category) { [weak self] response in
            
            if case let .success(item) = response,
               let item {
                let loadedItem = Output(categoryMovieList: item)
                self?.handler?(loadedItem)
            }
        }
    }
}

extension MovieInfoCollectionViewModel {
    struct Output {
        let categoryMovieList: MovieList
    }
}
