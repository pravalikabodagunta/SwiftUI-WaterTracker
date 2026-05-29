//
//  WaterViewModel.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import Foundation
import SwiftUI
internal import Combine

class WaterViewModel: ObservableObject {
    @Published var intakes: [WaterIntake] = []
    @Published var dailyGoal: DailyGoal = DailyGoal()
    
    private let intakesKey = "waterIntakes"
    private let goalKey = "dailyGoal"
    
    init() {
        loadData()
    }
    
    // MARK: - Computed Properties
    
    var todayIntakes: [WaterIntake] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return intakes.filter { calendar.isDate($0.timestamp, inSameDayAs: today) }
    }
    
    var totalToday: Double {
        todayIntakes.reduce(0) { $0 + $1.amount }
    }
    
    var progressPercentage: Double {
        guard dailyGoal.targetAmount > 0 else { return 0 }
        return min(totalToday / dailyGoal.targetAmount, 1.0)
    }
    
    var remainingAmount: Double {
        max(dailyGoal.targetAmount - totalToday, 0)
    }
    
    // MARK: - Actions
    
    func addWater(amount: Double) {
        let intake = WaterIntake(amount: amount)
        intakes.append(intake)
        saveData()
    }
    
    func deleteIntake(_ intake: WaterIntake) {
        intakes.removeAll { $0.id == intake.id }
        saveData()
    }
    
    func updateDailyGoal(newGoal: Double) {
        dailyGoal.targetAmount = newGoal
        saveData()
    }
    
    // MARK: - Persistence
    
    private func saveData() {
        if let encodedIntakes = try? JSONEncoder().encode(intakes) {
            UserDefaults.standard.set(encodedIntakes, forKey: intakesKey)
        }
        if let encodedGoal = try? JSONEncoder().encode(dailyGoal) {
            UserDefaults.standard.set(encodedGoal, forKey: goalKey)
        }
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: intakesKey),
           let decoded = try? JSONDecoder().decode([WaterIntake].self, from: data) {
            intakes = decoded
        }
        if let data = UserDefaults.standard.data(forKey: goalKey),
           let decoded = try? JSONDecoder().decode(DailyGoal.self, from: data) {
            dailyGoal = decoded
        }
    }
    
    func resetToday() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        intakes.removeAll { calendar.isDate($0.timestamp, inSameDayAs: today) }
        saveData()
    }
}

// Made with Bob
