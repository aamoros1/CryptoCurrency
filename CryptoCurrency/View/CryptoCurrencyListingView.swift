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
    var actor: SwiftDataClass
    
    private var serviceManager: CoinMarketServiceManaging
    var cryptoTokenNotification: NotificationCenter.Publisher = {
        CryptoToken().CryptoTokenPublisher
    }()
    var test: NotificationCenter.Publisher = {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextWillSave)
    }()
    
    init(modelContext: ModelContext, serviceManager: CoinMarketServiceManaging) {
//        modelContext.autosaveEnabled = false
        actor = SwiftDataClass(modelContext: modelContext)
        self.serviceManager = serviceManager
    }
    
    func fetchInitialTokens() async {
        do {
            tokens = try actor.fetchData(predicate: #Predicate { $0.isActive }, sortByDescription: [
                SortDescriptor(\.id)
            ])
            if tokens.isEmpty {
                tokens = try await serviceManager.fetchIinitialBatch(startAt: 1, limitBatchSize: 50)
                try actor.safeData(models: tokens)
            }
        } catch let error {
            print(error)
        }
    }
    
//    func registerNotification() async {
//        await actor.register()
//    }
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
        .onReceive(viewModel.test) { _ in
            /// Implement feature to reload savedData
//            context.autosaveEnabled = false
            Task {
//                print(await viewModel.actor.modelContext.insertedModelsArray)
            }
            print("did save")
        }
        .task(priority: .background) {
//            await viewModel.registerNotification()
//            viewModel.actor.modelContext.autosaveEnabled = false
            await viewModel.fetchInitialTokens()

        }
        .navigationTitle("Tokens")
        .safeAreaPadding(.top)
    }
}
