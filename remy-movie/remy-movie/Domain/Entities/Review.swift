//
//  Review.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

struct Review: Decodable {
    let author: String
    let authorDetails: AuthorDetails
    let content: String
    let createdAt: String
    let id: String
    let updatedAt: String
    let url: String
}

struct AuthorDetails: Decodable {
    let name: String
    let userName: String
    let avatarPath: String?
    let rating: Double?
}
