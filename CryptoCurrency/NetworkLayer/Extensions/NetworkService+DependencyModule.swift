//
// NetworkService+DependencyModule.swift
// 
// Created by Alwin Amoros on 1/30/24.
// 

import Foundation
import NetworkComponents
import DependencyInjection

extension NetworkService: DependencyModule {
    static func register(with dependencyInjector: DependencyInjector) {
        dependencyInjector.register(.singleton, with1Arg: produceURLSessionConfiguration)
        dependencyInjector.register(.singleton, with1Arg: produceBaseNetworkServiceInterceptor)
        dependencyInjector.register(.singleton, with2Args: produceNetworkServiceProvider)
        dependencyInjector.register(.singleton, withNoArg: produceSharedCookieStorage)
        dependencyInjector.register(.singleton, with1Arg: produceNetworkService)
    }

    private static func produceURLSessionConfiguration(cookieStorage: HTTPCookieStorage)
    throws -> URLSessionConfiguration
    {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral

        urlSessionConfiguration.allowsCellularAccess = true
        urlSessionConfiguration.httpMaximumConnectionsPerHost = 1
        urlSessionConfiguration.timeoutIntervalForRequest = 1000
        urlSessionConfiguration.timeoutIntervalForResource = 1000
        urlSessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlSessionConfiguration.httpShouldSetCookies = true
        urlSessionConfiguration.httpCookieStorage = cookieStorage

        return urlSessionConfiguration
    }

    private static func produceNetworkServiceProvider(urlSessionConguration: URLSessionConfiguration,
                                                          interceptor: BaseNetworkServiceInterceptor)
    throws -> NetworkServiceProvider
    {
        let networkServiceProvider = BaseNetworkServiceProvider(config: urlSessionConguration)
        networkServiceProvider.interceptor = interceptor

        return networkServiceProvider
    }
    
    private static func produceNetworkService(with provider: NetworkServiceProvider) throws -> NetworkService {
        return NetworkService(with: provider)
    }

    fileprivate static func produceSharedCookieStorage() throws -> HTTPCookieStorage {
        return HTTPCookieStorage.shared
    }
    
    private static func produceBaseNetworkServiceInterceptor(cookieStorage: HTTPCookieStorage) throws -> BaseNetworkServiceInterceptor {
        return BaseNetworkServiceInterceptor(with: cookieStorage)
    }
}
