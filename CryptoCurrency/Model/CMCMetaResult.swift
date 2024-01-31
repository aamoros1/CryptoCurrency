//
// CMCMetaResult.swift
// 
// Created by Alwin Amoros on 11/26/23.
//

import Foundation

struct CMCMetaStatus: Codable {
    let timestamp: String
    let errorCode: Int
    let errorMessage: String
    let elapsed: Int
    let creditCount: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(String.self, forKey: .timestamp)
        self.errorCode = try container.decode(Int.self, forKey: .errorCode)
        self.errorMessage = try container.decode(String.self, forKey: .errorMessage)
        self.elapsed = try container.decode(Int.self, forKey: .elapsed)
        self.creditCount = try container.decode(Int.self, forKey: .creditCount)
    }
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case elapsed
        case creditCount = "credit_count"
    }
}

struct CMCMetaResult: Codable {
    let status: CMCMetaStatus
}
