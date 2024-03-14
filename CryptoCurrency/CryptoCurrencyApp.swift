//
// CryptoCurrencyApp.swift
// 
// 
// 

import SwiftUI
import Observation
import SwiftData

@main
struct CryptoCurrencyApp: App {
    
    let serviceManager: CoinMarketServiceManager = CoinMarketServiceManager()
//    var swiftDataManager: SwiftDataManager = SwiftDataManager(CryptoToken.self)

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(serviceManager)
                .task(priority: .background) {
                    Context.registerDependencies()
                    await serviceManager.fetchKeyDetail()
                }
        }
        .environment(serviceManager)
        .modelContainer(for: CryptoToken.self)
//        .modelContext(swiftDataManager.context)
    }
}


struct MainView: View {
    @Environment(\.modelContext) var context
    @Environment(CoinMarketServiceManager.self) private var serviceManager
    var body: some View {
        TabView {
            CryptoCurrencyListingView(viewModel: .init(modelContext: context, serviceManager: serviceManager))
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
