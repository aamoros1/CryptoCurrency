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
    func processRequest(_ request: NetworkRequest, 
                        content: Any?) async
    -> AsyncToken 
    {
        await provider.process(request, content: content)
    }
}
