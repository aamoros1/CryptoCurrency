//
// KeyDetailView.swift
// 
//
// 

import SwiftUI
import Foundation

struct KeyDetailView: View {

    @Environment(CoinMarketServiceManager.self) var serviceManager

    struct KeyDetailViewConstant {
        static let currentDayHeader: String = String(localized: "KeyDetailView.currentDay")
        static let currentMinuteHeader: String = String(localized: "KeyDetailView.currentMinute")
        static let currentMonthHeader: String = String(localized: "KeyDetailView.currentMonth")
    }

    var body: some View {
        VStack {
            KeyDetailPlanView(keyDetailPlan: serviceManager.keydetail!.plan)
            Divider()
            Text("Usage")
                .font(.largeTitle)
            UsageRow(creditsUsed: (serviceManager.keydetail?.usage.currentMinute.requestsMade)!,
                     creditsRemaining: (serviceManager.keydetail?.usage.currentMinute.requestsLeft)!,
                     header: KeyDetailViewConstant.currentMinuteHeader)
            UsageRow(creditsUsed:(serviceManager.keydetail?.usage.currentDay.creditsUsed)!,
                     creditsRemaining:serviceManager.keydetail?.usage.currentDay.creditsLeft ?? 0,
                     header: KeyDetailViewConstant.currentDayHeader)
            UsageRow(creditsUsed:serviceManager.keydetail!.usage.currentMonth.creditsUsed,
                     creditsRemaining:serviceManager.keydetail!.usage.currentMonth.creditsLeft ?? 0,
                     header: KeyDetailViewConstant.currentMonthHeader)
        }
    }
}

fileprivate struct KeyDetailPlanView: View {

    struct KeyDetailConstant {
        static let KeyDetailPlanHeader: String = String(localized: "KeyDetailPlanView.Header")
        static let limitMonthlyReset: String = String(localized: "KeyDetailPlanView.CreditLimitMonthlyReset")
    }

    let keyDetailPlan: PlanDetail

    var body: some View {
        VStack {
            Text(KeyDetailConstant.KeyDetailPlanHeader)
                .font(.largeTitle)
            Text(String(format: KeyDetailConstant.limitMonthlyReset,
                        keyDetailPlan.creditLimitMonthlyReset))
        }
    }
}

fileprivate struct UsageRow: View {

    struct UseageRowConstant {
        static let usage: String = String(localized: "Usage.Row")
        static let remaining: String = String(localized: "Usage.Remaining")
    }

    let creditsUsed: Int
    let creditsRemaining: Int
    let header: String

    var body: some View {
        VStack {
            Text(header)
            HStack {
                Text(String(format: UseageRowConstant.usage, creditsUsed))
                Text(String(format: UseageRowConstant.remaining, creditsRemaining))
            }
        }
    }
}
