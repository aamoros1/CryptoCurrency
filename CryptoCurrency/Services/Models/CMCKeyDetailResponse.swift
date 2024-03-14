//
// CMCKeyDetailResponse.swift
// 
// Created by Alwin Amoros on 1/28/24.
// 

import Foundation

struct CMCResponse<Model: Codable>: Codable {
    let data: Model?
    let status: CMCStatusResponse
}

struct CMCStatusResponse: Codable {
    let timestamp: String
    let errorCode: Int
    let errorMessage: String?
    let elapsed: Int
    let creditCount: Int
    let notice: String?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case elapsed
        case creditCount = "credit_count"
        case notice
    }
}

struct KeyDetail: Codable {
    let plan: PlanDetail
    let usage: UseageDetail
}

struct PlanDetail: Codable {
    let creditLimitMonthly: Int
    let creditLimitMonthlyReset: String
    let creditLimitMonthlyResetTimestamp: String
    let rateLimitMinute: Int

    enum CodingKeys: String, CodingKey {
        case creditLimitMonthly = "credit_limit_monthly"
        case creditLimitMonthlyReset = "credit_limit_monthly_reset"
        case creditLimitMonthlyResetTimestamp = "credit_limit_monthly_reset_timestamp"
        case rateLimitMinute = "rate_limit_minute"
    }
}

struct RequestUsage: Codable {
    let requestsMade: Int
    let requestsLeft: Int
    
    enum CodingKeys: String, CodingKey {
        case requestsMade = "requests_made"
        case requestsLeft = "requests_left"
    }
}

struct CreditUsage: Codable {
    let creditsUsed: Int
    let creditsLeft: Int?

    enum CodingKeys: String, CodingKey {
        case creditsUsed = "credits_used"
        case creditsLeft = "credits_left"
    }
}
struct UseageDetail: Codable {
    let currentMinute: RequestUsage
    let currentDay: CreditUsage
    let currentMonth: CreditUsage

    enum CodingKeys: String, CodingKey {
        case currentMinute = "current_minute"
        case currentDay = "current_day"
        case currentMonth = "current_month"
    }
}
