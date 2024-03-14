//
// SwiftDataActor.swift
//
//
// 

import Foundation
import SwiftData

@ModelActor
actor SwiftDataActor {
    func safeData<Models: PersistentModel>(models: [Models]) async throws {
        guard !models.isEmpty else { return }
        try modelContext.transaction {
            models.forEach { modelContext.insert($0) }
            try modelContext.save()
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
