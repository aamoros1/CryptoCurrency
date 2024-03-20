//
// CryptoCurrencyRow.swift
// 
//
// 

import SwiftUI
import SwiftData
import Foundation

enum CryptoTokenColumns {
    case favorite
    case rank
    case name
    
    var columnName: String {
        switch self {
        case .favorite:
            return ""
        case .rank:
            return "#"
        case .name:
            return String(localized: "COLUMN.NAME")
        }
    }

    var gridItem: GridItem {
        switch self {
        case .favorite:
            return .init(.fixed(20))
        case .rank:
            return .init(.fixed(80))
        case .name:
            return .init(.fixed(200))
        }
    }
}

@Observable
final class CryptoCurrencyListingViewModel {
    var tokens: [CryptoToken] = []
    var actor: SwiftDataActor
    
    private var serviceManager: CoinMarketServiceManaging
    
    init(modelContext: ModelContext, serviceManager: CoinMarketServiceManaging) {
        actor = .init(modelContainer: modelContext.container)
        self.serviceManager = serviceManager
    }
    
    func fetchInitialTokens() async {
        do {
            tokens = try await actor.fetchData(predicate: #Predicate { $0.isActive }, sortByDescription: [
                SortDescriptor(\.id)
            ])
            if tokens.isEmpty {
                tokens = try await serviceManager.fetchIinitialBatch(startAt: 1, limitBatchSize: 50)
                try await actor.safeData(models: tokens)
            }
        } catch let error {
            print(error)
        }
    }
}

struct CryptoCurrencyListingView: View {
    @State var ascending = true
    @State private var viewModel: CryptoCurrencyListingViewModel
    @Environment(\.modelContext) var context
    
    let columns: [GridItem] = {
        [
            CryptoTokenColumns.favorite,
            CryptoTokenColumns.rank,
            CryptoTokenColumns.name]
            .map { $0.gridItem }
    }()
    
    init(viewModel: CryptoCurrencyListingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.tokens) { token in
                    CryptoCurrencyGridRow(cryptoToken: token)
                }
            }
        }
        .onReceive(CryptoToken.CryptoTokenPublisher) { _ in
            /// Implement feature to reload savedData
            print("did save")
        }
        .task(priority: .background) {
            await viewModel.fetchInitialTokens()
        }
        .navigationTitle("Tokens")
        .safeAreaPadding(.top)
    }
    
    @ViewBuilder
    private func buildCellFor(token: CryptoToken) -> some View {
        HStack {
            Text(token.name)
            Text(token.symbol)
        }
    }
}
