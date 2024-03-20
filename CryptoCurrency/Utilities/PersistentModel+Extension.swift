//
// PersistentModel+Extension.swift
// 
// 
//

import SwiftData
import Foundation

public extension PersistentModel {
    var notificationName: Notification.Name {
        .init(String(describing: type(of: self)))
    }
}
