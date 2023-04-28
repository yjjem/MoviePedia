//
//  ProvidersByCountryResponse.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


struct ProvidersByCountryResponse: Decodable {
    let en: ProvidersInfo?
    let kr: ProvidersInfo?
    let jp: ProvidersInfo?
    
    enum CodingKeys: String, CodingKey {
        case en = "EN"
        case kr = "KR"
        case jp = "JP"
    }
}
