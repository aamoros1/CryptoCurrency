//
// CryptoCurrencyApp.swift
// 
// Created by Alwin Amoros on 11/22/23.
// 

import SwiftUI
import Observation
import SwiftData

@main
struct CryptoCurrencyApp: App {
    
    let serviceManager: CoinMarketServiceManager = CoinMarketServiceManager()
    var swiftDataManager: SwiftDataManager = SwiftDataManager(CryptoToken.self)

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(serviceManager)
                .task(priority: .background) {
                    Context.registerDependencies()
                    await serviceManager.fetchKeyDetail()
                    let results = try? await serviceManager.fetchTokens(with: ["BTC", "USDT"])
                    print(results)
//                    JSONSerialization.jsonObject(with: <#T##Data#>, options: .topLevelDictionaryAssumed)
                }
        }
        .modelContainer(swiftDataManager.container)
    }
}

@ModelActor
actor SwiftDataCacheHandler {
    func saveCachedObjects(models: [any PersistentModel]) throws {
        models.forEach { model in
            modelContext.insert(model)
        }
        try modelContext.save()
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            CryptoCurrencyListingView()
                .tabItem {
                    Label("MainView.HomeTab", systemImage: "house")
                }
            KeyDetailView()
                .tabItem {
                    Label(
                        title: { Text("Usage") },
                        icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
)
                }
        }
    }
}
