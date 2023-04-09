//
//  MovieDetails.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct MovieDetails {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: Date?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [Languages]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: String?
    let voteAverage: Double?
    let voteCount: Int?
}

struct Languages {
    let iso6391: String?
    let name: String?
}

struct ProductionCompany {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originalCountry: String?
}

struct ProductionCountry {
    let iso31161: String?
    let name: String?
}

struct Genre {
    let id: Int?
    let name: String?
}
