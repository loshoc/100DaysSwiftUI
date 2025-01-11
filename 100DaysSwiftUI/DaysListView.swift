//
//  DaysListView.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/11.
//

import SwiftUI

struct DaysListView: View {
    let days = Array(1...100)
    
    var body: some View {
        NavigationStack {
            List(days, id: \.self) { day in
                NavigationLink {
                    DayDetailView(dayNumber: day)
                } label: {
                    Text("Day \(day)")
                }
            }
            .navigationTitle("SwiftUI Practice")
        }
    }
}

#Preview {
    DaysListView()
}
