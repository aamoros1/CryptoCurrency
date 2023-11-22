//
// Item.swift
// 
// Created by Alwin Amoros on 11/22/23.
// 

	

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
