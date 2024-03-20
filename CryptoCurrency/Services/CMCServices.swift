//
// CMCServices.swift
// 
//
//

import Observation
import Foundation
import NetworkComponents
import DependencyInjection


enum BaseNetworkServiceError: Error {
    case timeout(NetworkRequest)
    case genericError
    case serviceError(Error?)
}


protocol CoinMarketServiceManaging: NetworkServiceAccessor, AnyObject {
    func fetchKeyDetail() async
    func fetchIinitialBatch(
        startAt: Int,
        limitBatchSize: Int
    ) async  throws -> [CryptoToken]
}

@Observable
final class CoinMarketServiceManager: CoinMarketServiceManaging {
    private struct Constants {
        static let batchSize: Int = 50
        static let startAt: Int = 1
    }
    private let cryptoToolServices: CoinMarketCryptoToolServices = .init()
    var keydetail: KeyDetail? = nil

    func fetchKeyDetail() async
    {
        keydetail = try? await cryptoToolServices.fetchKeyDetailInfo()
    }

    func fetchIinitialBatch(
        startAt: Int = Constants.startAt,
        limitBatchSize: Int = Constants.batchSize
    ) async  throws -> [CryptoToken] {
        let query = [
            "start" : String(startAt),
            "limit": String(limitBatchSize)
        ]
        async let token = networkService.processRequest(with: .coinMarketCap, content: query)
        
        guard
            try await token.waitForCompletion(for: 5000)
        else {
            let response = try await token.result as? NetworkResponse
            return []
        }

        guard
            let response = try await token.result as? NetworkResponse
        else {
            throw NSError()
        }

        guard
            let cmcResponse = response.content as? CMCResponse<[CryptoToken]>
        else {
            //  handle error could be from server side
            return []
        }
        return cmcResponse.data ?? []
    }

    func fetchTokens(with symbolTokens: [String]) async throws -> [CryptoToken]? {
        let query = ["symbol": symbolTokens.joined(separator: ",")]
        async let token = networkService.processRequest(with: .coinMarketCap, content: query)
        
        guard
            try await token.waitForCompletion(for: 5000)
        else {
            throw BaseNetworkServiceError.timeout(.init(url: URL(string: "  ")!, method: ""))
        }
        
        guard
            let response = try await token.result as? NetworkResponse else {
            return nil
        }
        
        guard
            let cmcResponse = response.content as? CMCResponse<[CryptoToken]>
        else {
            throw BaseNetworkServiceError.serviceError(response.error)
        }
        
        return cmcResponse.data
    }
}

extension KeyDetail {
    static var defaultValue: Self {
        let planDetail: PlanDetail = .init(creditLimitMonthly: 120000,
                                           creditLimitMonthlyReset: "In 3 days, 19 hours, 56 minutes",
                                           creditLimitMonthlyResetTimestamp: "2019-09-01T00:00:00.000Z",
                                           rateLimitMinute: 60)
        let useageDetail: UseageDetail = .init(currentMinute: .init(requestsMade: 1, requestsLeft: 59),
                                               currentDay: .init(creditsUsed: 1, creditsLeft: 59),
                                               currentMonth: .init(creditsUsed: 1, creditsLeft: 59))
        return .init(plan: planDetail, usage: useageDetail)
    }
}

final class CoinMarketCryptoToolServices: NetworkServiceAccessor {
    
    func fetchKeyDetailInfo() async throws -> KeyDetail? {
        
        async let token = try! await networkService.processRequest(with: .keyDetailStatistics, content: nil)
        
        guard 
            await token.waitForCompletion(for: 5000)
        else {
            throw NSError()
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
