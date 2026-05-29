//
//  IntakeRow.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import SwiftUI

struct IntakeRow: View {
    let intake: WaterIntake
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "drop.fill")
                .foregroundColor(.blue)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(Int(intake.amount)) ml")
                    .font(.headline)
                
                Text(intake.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct IntakeRow_Previews: PreviewProvider {
    static var previews: some View {
        IntakeRow(intake: WaterIntake(amount: 250)) {
            print("Delete tapped")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

// Made with Bob
