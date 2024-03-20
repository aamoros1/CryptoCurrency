//
// CryptoCurrencyGridRow.swift
// 
//
//

import SwiftUI
import Foundation

struct CryptoCurrencyGridRow: View {
    let cryptoToken: CryptoToken
    var body: some View {
        GridRow {
            Image(systemName: cryptoToken.isFavorite ? "star.fill" : "star")
                .foregroundStyle(
                    Color.yellow
                )
                .padding()
                .onTapGesture {
                    cryptoToken.isFavorite.toggle()
                }
            Text(cryptoToken.rank.description)
            HStack {
                Text(cryptoToken.name)
                Text(cryptoToken.symbol)
            }
        }
    }
}
