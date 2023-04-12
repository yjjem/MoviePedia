//
//  Bundle + apiKey.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

public let MainBundle = Bundle.main

extension Bundle {
    
    var apiKey: String? {
        return object(forInfoDictionaryKey: "MovieAPIKey") as? String
    }
}
