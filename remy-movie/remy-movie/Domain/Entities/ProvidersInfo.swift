//
//  ProvidersInfo.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct ProvidersInfo: Decodable {
    let link: String
    let buy: [ProviderDetails]
    let rent: [ProviderDetails]
    let flatrate: [ProviderDetails]
}

struct ProviderDetails: Decodable {
    let displayPriority: Int
    let logoPath: String
    let providerId: Int
    let providerName: String
}
