//
// CryptoCurrencyRow.swift
// 
//
// 

import Foundation
import SwiftUI
import SwiftData

struct CryptoCurrencyGridRow: View {
    
    let cryptoToken: CryptoToken
    var body: some View {
        GridRow(alignment: .lastTextBaseline) {
            Group {
                Image(systemName: cryptoToken.isFavorite ? "star.fill" : "star")
                    .foregroundStyle(
                        Color.yellow
                    )
                    .padding()
                    .onTapGesture {
                        cryptoToken.isFavorite.toggle()
                }
                Text(cryptoToken.rank.description)
            }
            Group {
                Spacer()
                HStack {
                    Text(cryptoToken.name)
                    Text(cryptoToken.symbol)
                }
                .padding()
                Spacer()
            }
            
        }
    }
}

struct CryptoCurrencyListingView: View {
    @Query(sort: \CryptoToken.rank) var tokens: [CryptoToken]
    var body: some View {
        ScrollView {
            Grid(alignment: .leading) {
                ForEach(tokens) { token in
                    CryptoCurrencyGridRow(cryptoToken: token)
                    GridRow {
                        Rectangle()
                            .fill(.secondary)
                            .frame(height: 1)
                            .gridCellColumns(5)
                            .gridCellUnsizedAxes([.horizontal])
                    }
                }
            }
        }
        .navigationTitle("Tokens")
        .safeAreaPadding(.top)
    }
}

#Preview {
    NavigationStack {
        let container = SwiftDataManager(models: CryptoToken.self)
        container.addPersistentDataModels(models: CryptoToken.previewCryptoTokens)

        return CryptoCurrencyListingView()
            .modelContainer(container.container)
    }
}
