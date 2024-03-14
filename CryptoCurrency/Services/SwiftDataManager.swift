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
//        registerNotifications()
    }

//    private func registerNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(willSave), name: .NSManagedObjectContextWillSave, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didSave), name: .NSManagedObjectContextDidSave, object: nil)
//    }

    @objc
    private func willSave(notification: NSNotification) {
        let notificationNames = context.insertedModelsArray.map { $0.notificationName }
        print("\(context.hasChanges)")
        Task {
            print("\(await context.container.mainContext.insertedModelsArray)")
        }
        print("\(context.changedModelsArray)")
        print("\(context.insertedModelsArray)")
        print("\(context.deletedModelsArray)")
        modelsToBeSaved = Set(notificationNames)
    }
    @objc
    private func didSave(notification: NSNotification) {
        print("\(context.hasChanges)")
        print("\(context.changedModelsArray)")
        print("\(context.insertedModelsArray)")
        print("\(context.deletedModelsArray)")
        modelsToBeSaved.forEach { notificationName in
            print("saved: \(notificationName)")
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }
}

extension ModelContext {
    func willSave() {
        print(insertedModelsArray)
    }
}
