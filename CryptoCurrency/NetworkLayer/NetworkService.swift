//
// NetworkService.swift
//
// Created by Alwin Amoros on 1/30/24.
//

import Foundation
import NetworkComponents

final class NetworkService {
    private let provider: NetworkServiceProvider!
    
    required init(with provider: NetworkServiceProvider) {
        self.provider = provider
    }
    
    @discardableResult
    func processRequest(
        _ request: NetworkRequest,
        content: Any?
    ) async -> AsyncToken {
        await provider.process(request, content: content)
    }
    
    func processRequest(
        with kind: NetworkRequestKind,
        content: Any?
    ) async throws -> AsyncToken {
        let request = try kind.buildNetworkRequest(content: content as? [String: String])

        return await processRequest(request, content: nil)
    }
}

extension NetworkService {

    static func buildBaseURL<RequestKind: NetworkRequestKind>(
        with kind: RequestKind
    ) throws -> URL {
        try baseURl(with: kind.path)
    }

    static func baseURl(with path: String) throws -> URL {
        return try urlWith(path: path, relativeTo: try baseURL())
    }

    private static func urlWith(path: String, relativeTo domainURL: URL) throws -> URL {
        guard let url = URL(string: path, relativeTo: domainURL) else {
            throw NSError()
        }
        return url
    }

    static func baseURL() throws -> URL {
        return try urlWith(ServiceURL.baseURL)
    }
    
    static private func urlWith(
        _ urlString: String
    ) throws -> URL {
        guard
            let url = URL(string: urlString)
        else {
            throw NSError()
        }
        return url
    }
}
