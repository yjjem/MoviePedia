//
//  WatchProviders.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct ProvidersInfo: Decodable {
    let en: ProviderList?
    let kr: ProviderList?
    let jp: ProviderList?
}

struct ProviderList: Decodable {
    let link: String?
    let flatrate: [Provider]?
    let rent: [Provider]?
    let buy: [Provider]?
}

struct Provider: Decodable {
    let displayPriority: Int?
    let logoPath: String?
    let providerId: Int?
    let providerName: String?
}
