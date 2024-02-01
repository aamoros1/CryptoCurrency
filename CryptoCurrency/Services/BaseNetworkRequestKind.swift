//
// BaseNetworkRequestKind.swift
// 
//
//

import Foundation
import NetworkComponents

final class BaseNetworkRequestKind: NetworkRequestKind {
    
    override func buildUrl() throws -> URL {
        try NetworkService.buildBaseURL(with: self)
    }
}
