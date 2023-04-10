//
//  EnPoint.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct EndPoint {
    let host: String
    let path: String
    let queryItems: [URLQueryItem]?
    
    var url: URL? {
        let apiKeyQuery = URLQueryItem(
            name: "api_key",
            value: "732290ecd73a04df51eec3e64bada69a"
        )
        var components = URLComponents(string: host)
        components?.path = path
        components?.queryItems = queryItems
        components?.queryItems?.append(apiKeyQuery)
        return components?.url
    }
}
