//
//  ContentView.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WaterViewModel
    @State private var showingAddWater = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Progress Section
                        VStack(spacing: 15) {
                            Text("Today's Progress")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            // Circular Progress
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                                    .frame(width: 200, height: 200)
                                
                                Circle()
                                    .trim(from: 0, to: viewModel.progressPercentage)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                    )
                                    .frame(width: 200, height: 200)
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut, value: viewModel.progressPercentage)
                                
                                VStack(spacing: 5) {
                                    Text("\(Int(viewModel.totalToday))")
                                        .font(.system(size: 40, weight: .bold))
                                    Text("ml")
                                        .font(.title3)
                                        .foregroundColor(.secondary)
                                    Text("of \(Int(viewModel.dailyGoal.targetAmount)) ml")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            // Remaining amount
                            if viewModel.remainingAmount > 0 {
                                Text("\(Int(viewModel.remainingAmount)) ml remaining")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            } else {
                                Text("🎉 Goal achieved!")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        
                        // Quick Add Buttons
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Quick Add")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            HStack(spacing: 15) {
                                QuickAddButton(amount: 250, icon: "☕️") {
                                    viewModel.addWater(amount: 250)
                                }
                                QuickAddButton(amount: 500, icon: "🥤") {
                                    viewModel.addWater(amount: 500)
                                }
                                QuickAddButton(amount: 750, icon: "🍶") {
                                    viewModel.addWater(amount: 750)
                                }
                                QuickAddButton(amount: 1000, icon: "💧") {
                                    viewModel.addWater(amount: 1000)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Today's History
                        if !viewModel.todayIntakes.isEmpty {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Today's History")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 10) {
                                    ForEach(viewModel.todayIntakes.sorted(by: { $0.timestamp > $1.timestamp })) { intake in
                                        IntakeRow(intake: intake) {
                                            viewModel.deleteIntake(intake)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(15)
                                .shadow(radius: 3)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Water Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSettings = true }) {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddWater = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddWater) {
                AddWaterView()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WaterViewModel())
    }
}

// Made with Bob
