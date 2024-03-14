//
// CryptoCurrencyGridRow.swift
// 
//
//

import SwiftUI
import Foundation

struct CryptoCurrencyGridRow: View {
    @Environment(\.modelContext) var context
    let cryptoToken: CryptoToken
    var body: some View {
        GridRow {
            Group {
                Image(systemName: cryptoToken.isFavorite ? "star.fill" : "star")
                    .foregroundStyle(
                        Color.yellow
                    )
                    .padding()
                    .onTapGesture {
                        cryptoToken.isFavorite.toggle()
//                        try? context.save()
                    }
                    .gridColumnAlignment(.trailing)
                
                Text(cryptoToken.rank.description)
                    .gridColumnAlignment(.leading)
            }
            Group {
                Spacer()
                HStack {
                    Text(cryptoToken.name)
                    Text(cryptoToken.symbol)
                }
                Spacer()
            }
            
        }
    }
}
