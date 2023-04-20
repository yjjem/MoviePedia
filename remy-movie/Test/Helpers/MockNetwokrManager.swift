//
//  MockNetwokrManager.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

@testable import remy_movie
import Foundation

final class MockNetworkManager: Networkable {
    
    static var mockHandler: (() -> (NetworkError?, Data?))?
    
    func load(
        url: URL?,
        method: HTTPMethod,
        completion: @escaping (FailableData) -> Void
    ) -> URLSessionDataTask? {
        
        guard let mockHandler = MockNetworkManager.mockHandler else { return nil }
        
        let (error, data) = mockHandler()
        
        if let error = error {
            completion(.failure(error))
        }
        
        if let data = data {
            completion(.success(data))
        }
        
        return nil
    }
        
    func upload(
        data: Data?,
        url: URL?,
        method: HTTPMethod,
        completion: @escaping (NetworkError?) -> Void
    ) -> URLSessionUploadTask? {
        
        guard let mockHandler = MockNetworkManager.mockHandler else { return nil }
        
        let (error, _) = mockHandler()
        
        if let error = error {
            completion(error)
        }
        
        return nil
    }
}
