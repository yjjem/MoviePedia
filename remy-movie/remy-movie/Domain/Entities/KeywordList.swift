//
//  Keywords.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct KeywordList: Decodable {
    let id: Int?
    let keywords: [Keyword]?
}

struct Keyword: Decodable {
    let id: Int?
    let name: String?
}
