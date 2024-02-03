//
// SwiftDataManager+Extension.swift
// 
//
// 


import SwiftData
import Foundation

#if DEBUG
extension SwiftDataManager {
    func addPersistentDataModels(models: [any PersistentModel]) {
        Task {
            let actor = SwiftDataCacheHandler(modelContainer: container)
            try! await actor.saveCachedObjects(models: models)
        }
    }
}
#endif
