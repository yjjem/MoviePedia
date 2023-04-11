//
//  EndPoint.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

struct EndPoint {
    let host: String
    let path: String
    let queryItems: [QueryKey: String]?
    
    var url: URL? {
        var components = URLComponents(string: host)
        components?.path = path
        components?.queryItems = queryItems?.map { URLQueryItem(name: $0.name, value: $1) }
        return components?.url
    }
}

extension EndPoint {
    enum QueryKey {
        case language
        case page
        case region
        case apiKey
        
        var name: String {
            switch self {
            case .language: return "language"
            case .page: return "page"
            case .region: return "region"
            case .apiKey: return "api_key"
            }
        }
    }
}
