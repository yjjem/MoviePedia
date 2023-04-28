//
//  MovieDetails.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


struct MovieDetails: Decodable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbId: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [Language]
    let status: String
    let tagline: String?
    let title: String
    let video: String
    let voteAverage: Double
    let voteCount: Int
}

struct Language: Decodable {
    let iso6391: String
    let name: String
}

struct ProductionCompany: Decodable {
    let id: Int
    let logoPath: String
    let name: String
    let originalCountry: String
}

struct ProductionCountry: Decodable {
    let iso31161: String
    let name: String
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
