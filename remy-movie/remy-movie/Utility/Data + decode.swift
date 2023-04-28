//
//  Data + decode.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

extension Data {
    
    func tryDecode<Item: Decodable>(as type: Item.Type) -> Result<Item, NetworkError> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode(Item.self, from: self)
            return .success(decodedData)
        } catch {
            return .failure(.decodeFailed(error))
        }
    }
}

