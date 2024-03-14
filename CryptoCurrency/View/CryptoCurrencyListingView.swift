//
// CryptoCurrencyRow.swift
// 
//
// 

import SwiftUI
import SwiftData
import Foundation

@Observable
final class CryptoCurrencyListingViewModel {
    var tokens: [CryptoToken] = []
    var actor: SwiftDataActor
    
    private var serviceManager: CoinMarketServiceManaging
    var cryptoTokenNotification: NotificationCenter.Publisher = {
        CryptoToken().CryptoTokenPublisher
    }()
    
    init(modelContext: ModelContext, serviceManager: CoinMarketServiceManaging) {
        actor = SwiftDataActor(modelContainer: modelContext.container)
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
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(viewModel: CryptoCurrencyListingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.tokens) { token in
                    CryptoCurrencyGridRow(cryptoToken: token)
                        .gridColumnAlignment(.leading)
                    Separator()
                }
            }
        }
        .onReceive(viewModel.cryptoTokenNotification) { _ in
            /// Implement feature to reload savedData
            print("did save")
        }
        .task(priority: .background) {
            await viewModel.fetchInitialTokens()

        }
        .navigationTitle("Tokens")
        .safeAreaPadding(.top)
    }
}
