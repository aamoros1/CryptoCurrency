//
// ListView.swift
// 
//
// 

	
import SwiftUI
import Foundation
import SwiftData
private class Mock: CoinMarketServiceManaging {
    func fetchKeyDetail() async {
        
    }
    
    func fetchIinitialBatch(startAt: Int, limitBatchSize: Int) async throws -> [CryptoToken] {
        []
    }
}

#Preview {
    NavigationStack {
        let container = SwiftDataManager(models: CryptoToken.self)
        container.addPersistentDataModels(models: CryptoToken.previewCryptoTokens)
        return CryptoCurrencyListingView(viewModel: .init(modelContext: container.context, serviceManager: Mock()))
            .modelContainer(container.container)
    }
}
