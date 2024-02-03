//
// SwiftDataManager.swift
// 
//
//

import SwiftData
import Foundation

final class SwiftDataManager {

    private let schema: Schema
    private let config: ModelConfiguration
    private(set) var container: ModelContainer
    
    
    init(models: any PersistentModel.Type...) {
        schema = Schema(models)
        config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    init(_ models: any PersistentModel.Type...) {
        let urlForDataBase = URL.documentsDirectory.appending(path: "CtyptoToken.store")
        
        schema = Schema(models)
        config = ModelConfiguration(schema: schema, url: urlForDataBase)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
