//
//  Networkable.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.

import Foundation

protocol Networkable {
    typealias FailableData = Result<Data, NetworkError>
    
    func load(
        url: URL?,
        method: HTTPMethod,
        completion: @escaping (FailableData) -> Void
    ) -> URLSessionDataTask?
    
    func upload(
        data: Data?,
        url: URL?,
        method: HTTPMethod,
        completion: @escaping (NetworkError?) -> Void
    ) -> URLSessionUploadTask?
}
