//
// Context.swift
// 
//
//

import Foundation
import DependencyInjection

final class Context {
    static let dependencyInjector: DependencyInjector = DependencyInjector()
    
    class func registerDependencies() {
        NetworkService.register(with: dependencyInjector)
    }
}

extension DependencyInjectable {
    var injector: DependencyInjector {
        Context.dependencyInjector
    }

    static var injector: DependencyInjector {
        Context.dependencyInjector
    }
}
