//
//  MovieInfoViewModel.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


struct MovieInfoViewModel {
    let backdropPath: String?
    let posterPath: String?
    let title: String
    let userScore: Double
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.userScore = movie.voteAverage
        self.backdropPath = movie.backdropPath
        self.posterPath = movie.posterPath
    }
}
