//
// CryptoToken+Extension.swift
// 
// 
//

import Foundation

extension CryptoToken {
    static var previewCryptoTokens: [CryptoToken] {
        var tokens: [CryptoToken] = []
        
        tokens.append(.init(rankt: 1, name: "Bitcoin", symbol: "BTC"))
        tokens.append(.init(rankt: 2, name: "Ethereum", symbol: "ETH"))
        tokens.append(.init(rankt: 3, name: "Maker", symbol: "MKR"))
        tokens.append(.init(rankt: 4, name: "BNB", symbol: "BNB"))
        tokens.append(.init(rankt: 5, name: "Bitcoin Cash", symbol: "BCH"))
        tokens.append(.init(rankt: 6, name: "Monero", symbol: "XMR"))
        tokens.append(.init(rankt: 7, name: "Quant", symbol: "QNT"))
        tokens.append(.init(rankt: 8, name: "Solana", symbol: "SOL"))
        tokens.append(.init(rankt: 9, name: "Bitcoin", symbol: "BTC"))
        tokens.append(.init(rankt: 10, name: "Ethereum", symbol: "ETH"))
        tokens.append(.init(rankt: 11, name: "Maker", symbol: "MKR"))
        tokens.append(.init(rankt: 12, name: "BNB", symbol: "BNB"))
        tokens.append(.init(rankt: 13, name: "Bitcoin Cash", symbol: "BCH"))
        tokens.append(.init(rankt: 14, name: "Monero", symbol: "XMR"))
        tokens.append(.init(rankt: 15, name: "Quant", symbol: "QNT"))
        tokens.append(.init(rankt: 16, name: "Solana", symbol: "SOL"))
        return tokens
    }
}
