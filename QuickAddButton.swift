//
//  QuickAddButton.swift
//  WaterTracker
//
//  Created on 2026-05-29
//

import SwiftUI

struct QuickAddButton: View {
    let amount: Double
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(icon)
                    .font(.system(size: 30))
                
                Text("\(Int(amount))")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("ml")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.cyan.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 3)
        }
    }
}

struct QuickAddButton_Previews: PreviewProvider {
    static var previews: some View {
        QuickAddButton(amount: 250, icon: "☕️") {
            print("Added 250ml")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

// Made with Bob
