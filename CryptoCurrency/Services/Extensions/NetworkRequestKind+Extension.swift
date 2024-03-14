//
// NetworkRequestKind+Extension.swift
// 
//
//

import Foundation
import NetworkComponents

extension NetworkRequestKind {
    static var keyDetailStatistics = BaseNetworkRequestKind(appJsonPath: "/v1/key/info",
                                                            method: HttpMethod.get,
                                                            responseType: CMCResponse<KeyDetail>.self)
    
    static var coinMarketCap = BaseNetworkRequestKind(appJsonPath: "/v1/cryptocurrency/map", 
                                                      method: HttpMethod.get,
                                                      responseType: CMCResponse<[CryptoToken]>.self)
}
