//
//  NetworkError.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


enum NetworkError: Error {
    case badURL
    case badResponse(_ code: Int)
    case notHTTPURLResponse
    case requestFailed(_ error: Error)
    case emptyData
    case decodeFailed(_ error: Error)
}

