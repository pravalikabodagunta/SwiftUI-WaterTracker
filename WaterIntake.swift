//
//  WaterIntake.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import Foundation

struct WaterIntake: Identifiable, Codable {
    let id: UUID
    let amount: Double // in milliliters
    let timestamp: Date
    
    init(id: UUID = UUID(), amount: Double, timestamp: Date = Date()) {
        self.id = id
        self.amount = amount
        self.timestamp = timestamp
    }
}

struct DailyGoal: Codable {
    var targetAmount: Double // in milliliters
    
    init(targetAmount: Double = 2000) {
        self.targetAmount = targetAmount
    }
}

// Made with Bob
