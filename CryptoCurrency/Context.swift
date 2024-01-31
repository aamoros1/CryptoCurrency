//
// Context.swift
// 
// Created by Alwin Amoros on 1/30/24.
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
