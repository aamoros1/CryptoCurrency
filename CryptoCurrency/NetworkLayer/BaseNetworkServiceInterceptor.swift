//
// BaseNetworkServiceInterceptor.swift
// 
// Created by Alwin Amoros on 1/30/24.
//

import Foundation
import NetworkComponents

final class BaseNetworkServiceInterceptor: NetworkServiceInterceptor {
    
    private lazy var apiKey: String = {
        guard
            let key = Bundle.main.object(forInfoDictionaryKey: "ApIKey") as? String
        else {
            fatalError("APIKey property was not found in the Info.plist")
        }
        return key
    }()
    
    private let cookieStorage: HTTPCookieStorage

    public required init(with cookieStorage: HTTPCookieStorage) {
        self.cookieStorage = cookieStorage
    }

    func inspect(request: NetworkComponents.NetworkRequest)
    {
        request.headers["X-CMC_PRO_API_KEY"] = apiKey
    }
    
    func securityHeaders(for request: NetworkRequest,
                         containing body: Data?)
    -> [String : String]?
    {
        return nil
    }
    
    func inspect(response: NetworkResponse,
                 for request: NetworkRequest)
    {
        
    }
    
    func inspect(challenge: URLAuthenticationChallenge) -> URLCredential?
    {
        nil
    }
    
    func validatePinning(challenge: URLAuthenticationChallenge)
    -> Bool
    {
        true
    }
}
