//
//  NetworkManager.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

final class NetworkManager: Networkable {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    func load(
        url: URL?,
        method: HTTPMethod,
        completion: @escaping (FailableData) -> Void
    ) -> URLSessionDataTask? {
        
        guard let request = makeRequest(url: url, method: method) else { return nil }
        
        let session = session.dataTask(with: request) {
            [weak self] data, response, error in
            
            if let notValid = self?.checkSessionValidity(error: error, response: response) {
                completion(.failure(notValid))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            completion(.success(data))
        }
        
        session.resume()
        
        return session
    }
    
    func upload(
        data: Data?,
        url: URL?,
        method: HTTPMethod,
        completion: @escaping (NetworkError?) -> Void
    ) -> URLSessionUploadTask? {
        
        guard let request = makeRequest(url: url, method: method) else {
            completion(.badURL)
            return nil
        }
        
        let session = session.uploadTask(with: request, from: data) {
            [weak self] _, response, error in
            completion(self?.checkSessionValidity(error: error, response: response))
        }
        
        session.resume()
        
        return session
    }
    
    private func makeRequest(url: URL?, method: HTTPMethod) -> URLRequest? {
        
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.name
        
        return request
    }
    
    private func checkSessionValidity(error: Error?, response: URLResponse?) -> NetworkError? {
        
        if let error = error {
            return .requestFailed(error)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .notHTTPURLResponse
        }
        
        guard (200...299) ~= response.statusCode else {
            return .badResponse(response.statusCode)
        }
        
        return nil
    }
}
