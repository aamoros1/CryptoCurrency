//
// SwiftDataActor.swift
//
//
// 

import Foundation
import SwiftData

final class SwiftDataClass {
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        registerNotifications()
    }

    private func registerNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(willSave), name: .NSManagedObjectContextWillSave, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSave), name: .NSManagedObjectContextDidSave, object: nil)
    }

    @objc
    private func willSave() {
        print(#function)
        print(modelContext.insertedModelsArray)
    }

    @objc
    private func didSave() {
        print(#function)
        print(modelContext.insertedModelsArray)
    }

    func safeData<Models: PersistentModel>(models: [Models]) throws {
        guard !models.isEmpty else { return }
//        try modelContext.transaction {
            models.forEach { modelContext.insert($0) }
//            print(modelContext.insertedModelsArray)
//            try modelContext.save()
//        }
        let model = models.first!
        NotificationCenter.default.post(name: model.notificationName, object: nil)
    }

    func fetchData<Model: PersistentModel>(
        predicate: Predicate<Model>? = nil,
        sortByDescription: [SortDescriptor<Model>] = [],
        batchSize: Int = 50
    ) throws -> [Model] {
        let fetchDescriptor = FetchDescriptor<Model>(predicate: predicate,
                                                     sortBy: sortByDescription)
        let fetchedData = try modelContext.fetch(fetchDescriptor)
        return fetchedData
    }

    func fetchCount<Model: PersistentModel>(
        predicate: Predicate<Model>? = nil,
        sortByDescription: [SortDescriptor<Model>] = [],
        batchSize: Int = 50
    ) throws -> Int {
        let fetchDescriptor = FetchDescriptor<Model>(predicate: predicate,
                                                     sortBy: sortByDescription)
        let count = try modelContext.fetchCount(fetchDescriptor)
        return count
    }
}

@ModelActor
actor SwiftDataActor {

    func safeData<Models: PersistentModel>(models: [Models]) async throws {
        guard !models.isEmpty else { return }
        try modelContext.transaction {
            models.forEach { modelContext.insert($0) }
//            print(modelContext.insertedModelsArray)
//            try modelContext.save()
        }
        let model = models.first!
        NotificationCenter.default.post(name: model.notificationName, object: nil)
    }

    func fetchData<Model: PersistentModel>(
        predicate: Predicate<Model>? = nil,
        sortByDescription: [SortDescriptor<Model>] = [],
        batchSize: Int = 50
    ) throws -> [Model] {
        let fetchDescriptor = FetchDescriptor<Model>(predicate: predicate,
                                                     sortBy: sortByDescription)
        let fetchedData = try modelContext.fetch(fetchDescriptor)
        return fetchedData
    }

    func fetchCount<Model: PersistentModel>(
        predicate: Predicate<Model>? = nil,
        sortByDescription: [SortDescriptor<Model>] = [],
        batchSize: Int = 50
    ) throws -> Int {
        let fetchDescriptor = FetchDescriptor<Model>(predicate: predicate,
                                                     sortBy: sortByDescription)
        let count = try modelContext.fetchCount(fetchDescriptor)
        return count
    }
    
}
