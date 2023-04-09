//
//  MovieVideos.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct Video: Decodable {
    let iso6391: String?
    let iso31661: String?
    let name: String?
    let key: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt: Date?
    let id: String?
}
