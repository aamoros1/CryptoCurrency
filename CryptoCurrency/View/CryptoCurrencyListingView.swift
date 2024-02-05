//
// CryptoCurrencyRow.swift
// 
//
// 

import Foundation
import SwiftUI
import SwiftData

struct CryptoCurrencyListingView: View {
    @Query(sort: \CryptoToken.rank) var tokens: [CryptoToken]
    var body: some View {
        ScrollView {
            Grid(alignment: .leading) {
                ForEach(tokens) { token in
                    CryptoCurrencyGridRow(cryptoToken: token)
                        .gridColumnAlignment(.leading)
                    Separator()
                }
            }
        }
        .navigationTitle("Tokens")
        .safeAreaPadding(.top)
    }
}
