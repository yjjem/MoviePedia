//
//  GenericList.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct GenericList<Item: Decodable>: Decodable {
    let id: Int?
    let page: Int?
    let results: [Item]?
    let totalPages: Int?
    let totalResults: Int?
}
