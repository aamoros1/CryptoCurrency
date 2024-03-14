//
// SwiftDataManager.swift
// 
//
//

//import SwiftData
//import Foundation
//
//final class SwiftDataManager {
//    static let shared = SwiftDataManager()
//    private let schema: Schema
//    private let config: ModelConfiguration
//    private(set) var container: ModelContainer
//    let context: ModelContext
//    private var modelsToBeSaved: Set<Notification.Name> = []
//    
//    init(models: any PersistentModel.Type...) {
//        schema = Schema(models)
//        config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
//        do {
//            container = try ModelContainer(for: schema, configurations: config)
//        } catch let error {
//            fatalError(error.localizedDescription)
//        }
//        context = ModelContext(container)
//        context.autosaveEnabled = false
//    }
//
//    init(_ models: any PersistentModel.Type...) {
//        let urlForDataBase = URL.documentsDirectory.appending(path: "CtyptoToken.store")
//        
//        schema = Schema(models)
//        config = ModelConfiguration(schema: schema, url: urlForDataBase)
//        
//        do {
//            container = try ModelContainer(for: schema, configurations: config)
//        } catch let error {
//            fatalError(error.localizedDescription)
//        }
////        container.deleteAllData()
//        context = ModelContext(container)
//        context.autosaveEnabled = false
//        try? context.delete(model: CryptoToken.self)
//        print("\(context.hasChanges)")
//        print("\(context.changedModelsArray)")
//        print("\(context.insertedModelsArray)")
//        print("\(context.deletedModelsArray)")
//        try? context.save()
//        registerNotifications()
//    }
//
//    private func registerNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(willSave), name: .NSManagedObjectContextWillSave, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didSave), name: .NSManagedObjectContextDidSave, object: nil)
//    }
//
//    @objc
//    private func willSave(notification: NSNotification) {
//        let notificationNames = context.changedModelsArray.map { $0.notificationName }
//        print("\(context.hasChanges)")
//        print("\(context.changedModelsArray)")
//        print("\(context.insertedModelsArray)")
//        print("\(context.deletedModelsArray)")
//        modelsToBeSaved = Set(notificationNames)
//    }
//    @objc
//    private func didSave(notification: NSNotification) {
//        print("\(context.hasChanges)")
//        print("\(context.changedModelsArray)")
//        print("\(context.insertedModelsArray)")
//        print("\(context.deletedModelsArray)")
//        modelsToBeSaved.forEach { notificationName in
//            print("saved: \(notificationName)")
//            NotificationCenter.default.post(name: notificationName, object: nil)
//        }
//    }
//}
