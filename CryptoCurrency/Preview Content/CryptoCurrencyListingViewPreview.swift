//
// ListView.swift
// 
// Created by Alwin Amoros on 2/4/24.
// 

	
import SwiftUI
import Foundation

#Preview {
    NavigationStack {
        let container = SwiftDataManager(models: CryptoToken.self)
        container.addPersistentDataModels(models: CryptoToken.previewCryptoTokens)
        return CryptoCurrencyListingView()
            .modelContainer(container.container)
    }
}
