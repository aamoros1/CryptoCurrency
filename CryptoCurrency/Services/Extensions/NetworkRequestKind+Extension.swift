//
// NetworkRequestKind+Extension.swift
// 
// Created by Alwin Amoros on 2/2/24.
//

import Foundation
import NetworkComponents

extension NetworkRequestKind {
    static var keyDetailStatistics = BaseNetworkRequestKind(appJsonPath: "/v1/key/info",
                                                            method: HttpMethod.get,
                                                            responseType: CMCResponse<KeyDetail>.self)
}
