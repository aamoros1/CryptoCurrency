//
// SwiftDataManager.swift
// 
//
//

import SwiftData
import Foundation

@Observable
final class SwiftDataManager {

    private let schema: Schema
    private let config: ModelConfiguration
    private(set) var container: ModelContainer
    private(set) var context: ModelContext
    private var modelsToBeSaved: Set<Notification.Name> = []
    
    init(models: any PersistentModel.Type...) {
        schema = Schema(models)
        config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: config)
            self.container = container
            let context = ModelContext(container)
            context.autosaveEnabled = false
            self.context = context
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
    }

    init(_ models: any PersistentModel.Type...) {
        let urlForDataBase = URL.documentsDirectory.appending(path: "CtyptoToken.store")
        
        schema = Schema(models)
        config = ModelConfiguration(schema: schema, url: urlForDataBase)
        
        do {
            let container = try ModelContainer(for: schema, configurations: config)
            let context = ModelContext(container)
            context.autosaveEnabled = false
            self.context = context
            self.container = container
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

