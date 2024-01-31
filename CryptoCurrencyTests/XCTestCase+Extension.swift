//
// XCTestCase+Extension.swift
// 
// Created by Alwin Amoros on 1/28/24.
// 

import Foundation
import XCTest

extension XCTestCase {
    func readJSONFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle(for: type(of: self)).path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            return nil
        }
        return nil
    }
}
