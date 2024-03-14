//
// CryptoCurrencyTests.swift
// 
//
// 

	

import XCTest
import SwiftData
@testable import CryptoCurrency

final class CryptoCurrencyTests: XCTestCase {

    private let dataManager: SwiftDataManager = .init(CryptoToken.self)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func setUp() {
        let example = CryptoToken(rankt: 1, name: "Bitcoin", symbol: "BTC")
        dataManager.context.insert(example)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let descript = FetchDescriptor<CryptoToken>(predicate: #Predicate { $0.isActive })
        let model = try? dataManager.context.fetch(descript).first!
        model?.isFavorite = false
        XCTAssertFalse(dataManager.context.insertedModelsArray.isEmpty)
        XCTAssertTrue(dataManager.context.deletedModelsArray.isEmpty)
        XCTAssertTrue(dataManager.context.changedModelsArray.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
