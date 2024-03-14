//
// NetworkServiceAccessor.swift
// 
//
//

import Foundation
import DependencyInjection

protocol NetworkServiceAccessor: DependencyInjectable {
    var networkService: NetworkService { get }
}

extension NetworkServiceAccessor {
    var networkService: NetworkService {
        do {
            return try injector.retrieve()
        } catch let error {
            fatalError("NetworkService is not registered with the DepenendencyInjector: \(error)")
        }
    }
}
