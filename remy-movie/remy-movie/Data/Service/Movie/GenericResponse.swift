//
//  GenericList.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct GenericResponse<Items: Decodable>: Decodable {
    let id: Int?
    let page: Int?
    let results: Items?
    let keywords: Items?
    let totalPages: Int?
    let totalResults: Int?
}

extension GenericResponse where Items == [Movie] {
    
    func asMovieList() -> [Movie]? {
        return results
    }
}

extension GenericResponse where Items == [Video] {
    
    func asVideList() -> [Video]? {
        return results
    }
}
