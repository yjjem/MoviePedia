//
//  WatchProviders.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct CountryProvidersList: Decodable {
    let id: Int?
    let results: Country?
}

struct Country: Decodable {
    let en: ProvidersInfo?
    let kr: ProvidersInfo?
    let jp: ProvidersInfo?
    
    enum CodingKeys: String, CodingKey {
        case en = "EN"
        case kr = "KR"
        case jp = "JP"
    }
}

struct ProvidersInfo: Decodable {
    let link: String?
    let buy: [Provider]?
    let rent: [Provider]?
    let flatrate: [Provider]?
}

struct Provider: Decodable {
    let displayPriority: Int?
    let logoPath: String?
    let providerId: Int?
    let providerName: String?
}
