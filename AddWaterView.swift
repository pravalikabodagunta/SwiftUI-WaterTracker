//
//  AddWaterView.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import SwiftUI

struct AddWaterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WaterViewModel
    @State private var waterAmount: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Water Amount")) {
                    HStack {
                        TextField("Enter amount", text: $waterAmount)
                            .keyboardType(.numberPad)
                        Text("ml")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Quick Select")) {
                    ForEach([100, 200, 250, 300, 500, 750, 1000], id: \.self) { amount in
                        Button(action: {
                            waterAmount = String(amount)
                        }) {
                            HStack {
                                Text("\(amount) ml")
                                    .foregroundColor(.primary)
                                Spacer()
                                if waterAmount == String(amount) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: addWater) {
                        HStack {
                            Spacer()
                            Text("Add Water")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(waterAmount.isEmpty || Double(waterAmount) == nil)
                }
            }
            .navigationTitle("Add Water")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addWater() {
        guard let amount = Double(waterAmount), amount > 0 else { return }
        viewModel.addWater(amount: amount)
        dismiss()
    }
}

struct AddWaterView_Previews: PreviewProvider {
    static var previews: some View {
        AddWaterView()
            .environmentObject(WaterViewModel())
    }
}

// Made with Bob
