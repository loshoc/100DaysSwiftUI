//
//  DayDetailView.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/11.
//

import SwiftUI

struct DayDetailView: View {
    let dayNumber: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            switch dayNumber {
            case 1:
                Day1View()
            case 2:
                Day2View()
            default:
                Text("Coming soon!")
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DayDetailView(dayNumber: 1)
    }
}
