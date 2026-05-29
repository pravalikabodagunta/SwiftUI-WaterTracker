//
//  SettingsView.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WaterViewModel
    @State private var goalAmount: String = ""
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Daily Goal")) {
                    HStack {
                        TextField("Goal amount", text: $goalAmount)
                            .keyboardType(.numberPad)
                            .onAppear {
                                goalAmount = String(Int(viewModel.dailyGoal.targetAmount))
                            }
                        Text("ml")
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Update Goal") {
                        updateGoal()
                    }
                    .disabled(goalAmount.isEmpty || Double(goalAmount) == nil)
                }
                
                Section(header: Text("Preset Goals")) {
                    ForEach([1500, 2000, 2500, 3000], id: \.self) { amount in
                        Button(action: {
                            goalAmount = String(amount)
                            updateGoal()
                        }) {
                            HStack {
                                Text("\(amount) ml")
                                    .foregroundColor(.primary)
                                Spacer()
                                if Int(viewModel.dailyGoal.targetAmount) == amount {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Data Management")) {
                    Button(action: {
                        showingResetAlert = true
                    }) {
                        HStack {
                            Text("Reset Today's Data")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Daily Goal")
                        Spacer()
                        Text("\(Int(viewModel.dailyGoal.targetAmount)) ml")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Total Entries Today")
                        Spacer()
                        Text("\(viewModel.todayIntakes.count)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .alert("Reset Today's Data", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    viewModel.resetToday()
                }
            } message: {
                Text("Are you sure you want to reset all water intake data for today? This action cannot be undone.")
            }
        }
    }
    
    private func updateGoal() {
        guard let amount = Double(goalAmount), amount > 0 else { return }
        viewModel.updateDailyGoal(newGoal: amount)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(WaterViewModel())
    }
}

// Made with Bob
