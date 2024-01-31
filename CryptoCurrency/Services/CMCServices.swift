//
// CMCServices.swift
// 
// Created by Alwin Amoros on 1/28/24.
//

import Foundation
import NetworkComponents
import DependencyInjection


enum BaseNetworkServiceError: Error {
    case timeout(NetworkRequest)
    case genericError
    case serviceError(Error?)
}

final class CoinMarketCryptoToolServices: NetworkServiceAccessor {
    
    func fetchKeyDetailInfo() async throws -> KeyDetail? {
        async let token = await networkService.processRequest(.keyDetailNetworkRequest,
                                                              content: nil)
        
        guard 
            await token.waitForCompletion(for: 5000)
        else {
            throw BaseNetworkServiceError.timeout(.keyDetailNetworkRequest)
        }
        
        guard
            let response = await token.result as? NetworkResponse else {
            return nil
        }
        
        guard 
            let cmcResponse = response.content as? CMCResponse<KeyDetail>
        else {
            throw BaseNetworkServiceError.serviceError(response.error)
        }
        
        return cmcResponse.data
    }
}

extension NetworkRequest {
    static var keyDetailNetworkRequest: NetworkRequest {
        let urlString = ServiceURL.baseURL + "/v1/key/info"
        let url = URL(string: urlString)!
        let request = NetworkRequest(url: url, method: "GET")
        request.responeType = CMCResponse<KeyDetail>.self
        return request
    }
}
