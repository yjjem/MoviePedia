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
