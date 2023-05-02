//
//  ListCategory.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

enum ListCategory {
    case popular
    case topRated
    case nowPlaying
    case upcoming
}

extension ListCategory: CaseIterable {
    var index: Int {
        switch self {
        case .popular: return 0
        case .topRated: return 1
        case .nowPlaying: return 2
        case .upcoming: return 3
        }
    }
    
    var name: String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        }
    }
    
    static var allNames: [String] {
        let allCases = ListCategory.allCases
        return allCases.map { $0.name }
    }
    
    static func category(of index: Int) -> Self {
        switch index {
        case 1: return .topRated
        case 2: return .nowPlaying
        case 3: return .upcoming
        default: return .popular
        }
    }
}
