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

@Observable
final class ViewModel {
    
    private var context: ModelContext
    
    init(context: ModelContext)
    {
        self.context = context
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            Text("hi")
                .tabItem {
                    Label("do", systemImage: "circle")
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
