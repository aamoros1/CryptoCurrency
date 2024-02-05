//
// CryptoToken.swift
// 
// Created by Alwin Amoros on 2/2/24.
//

import SwiftData
import Foundation

@Model
class CryptoToken: Codable {
    let id: Int
    let rank: Int
    let name: String
    let symbol: String
    let dateCreated: String
    let isActive: Bool
    var isFavorite: Bool = false

    init(
        rankt: Int,
        name: String,
        symbol: String
    ) {
        self.rank = rankt
        self.name = name
        self.symbol = symbol
        self.id = rankt
        dateCreated = Date().description(with: .current)
        isActive = true
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        rank = try container.decode(Int.self, forKey: .rank)
        name = try container.decode(String.self, forKey: .name)
        symbol = try container.decode(String.self, forKey: .symbol)
        dateCreated = try container.decode(String.self, forKey: .dateCreated)
        let number = try container.decode(Int.self, forKey: .isActive)
        isActive = number == 1
    }

    enum CodingKeys: String, CodingKey {
        case rank, name, symbol, id
        case dateCreated = "first_historical_data"
        case isActive = "is_active"
    }
}

extension CryptoToken {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(rank, forKey: .rank)
        try container.encode(name, forKey: .name)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(dateCreated, forKey: .dateCreated)
        try container.encode(isActive, forKey: .isActive)
    }
}
