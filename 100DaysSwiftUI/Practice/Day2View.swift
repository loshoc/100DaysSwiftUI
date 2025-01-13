//
//  Day2View.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/12.
//

import SwiftUI

struct Day2View: View {
    @State private var progress: Double = 0.0
    
    var body: some View {
        ZStack{
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color.green.opacity(0.15), lineWidth: 24)
                
                // Progress circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        AngularGradient(
                            colors: [
                                .green.opacity(0.2),
                                .green.opacity(0.5),
                                .green.opacity(0.8),
                            ],
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(345)
                        ),
                        style: StrokeStyle(lineWidth: 24, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                
                // Drag gesture circle
                Circle()
                    .fill(Color.white)
                    .shadow(radius: 3)
                    .frame(width: 32, height: 32)
                    .offset(y: -120) // Radius of the circle
                    .rotationEffect(.degrees(360 * progress))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Calculate angle from drag position
                                let vector = CGVector(dx: value.location.x, dy: value.location.y)
                                let angle = atan2(vector.dy, vector.dx) + .pi/2
                                let progress = (angle < 0 ? angle + 2 * .pi : angle) / (2 * .pi)
                                self.progress = Double(progress)
                            }
                    )
                
                // Display progress value
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .foregroundStyle(Color.green)
            }
            .frame(width: 240, height: 240)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.green.opacity(
                0.05 + (progress * 0.1) // This will range from 0.05 to 0.20 as progress goes from 0 to 1
            )
        )
    }
}

#Preview {
    Day2View()
}
