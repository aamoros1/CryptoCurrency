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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(serviceManager)
                .task(priority: .background) {
                    Context.registerDependencies()
                    await serviceManager.fetchKeyDetail()
                }
        }
        .modelContainer(sharedModelContainer)
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
