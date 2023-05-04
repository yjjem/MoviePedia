//
//  MovieWrapper.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

enum MovieWrapper: Hashable {
    case category(Movie)
    case daily(Movie)
    case weekly(Movie)
    
    var movie: Movie {
        switch self {
        case .category(let movie): return movie
        case .daily(let movie): return movie
        case .weekly(let movie): return movie
        }
    }
}
