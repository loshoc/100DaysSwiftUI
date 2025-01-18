//
//  Day7View.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/18.
//

import SwiftUI

struct Day7View: View {
    @State private var gradientLocations: [Double] = [0.08, 0.16, 0.29, 0.32, 0.41, 0.57, 0.75, 1.0]
    
    private var gradientColors: AngularGradient {
        AngularGradient(
            stops: zip(
                [Color(hex: "C686FF"), Color(hex: "F5B9EA"), Color(hex: "FFBA71"),
                 Color(hex: "AA6EEE"), Color(hex: "FF6778"), Color(hex: "BC82F3"),
                 Color(hex: "8D99FF"), Color(hex: "C686FF")],
                gradientLocations
            ).map { Gradient.Stop(color: $0.0, location: $0.1) },
            center: .center
        )
    }
    
    var body: some View {
        ZStack {
            // First rectangle (outermost)
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .inset(by: 5)
                        .stroke(gradientColors, lineWidth: 10)
                        .ignoresSafeArea()
                ) 
                .blur(radius: 10)
            
            // Second rectangle
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .inset(by: 3.5)
                        .stroke(gradientColors, lineWidth: 7)
                        .ignoresSafeArea()
                ) 
                .blur(radius: 5)
            
            // Third rectangle
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .inset(by: 2)
                        .stroke(gradientColors, lineWidth: 5)
                        .ignoresSafeArea()
                ) 
                .blur(radius: 2.5)
            
            // Fourth rectangle (innermost)
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .inset(by: 1)
                        .stroke(gradientColors, lineWidth: 2)
                        .ignoresSafeArea()
                ) 
                .blur(radius: 1)
        }
        .background(Color.black)
        .ignoresSafeArea()
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                updateLocations()
            }
            timer.tolerance = 0.01
        }
    }
    
    private func updateLocations() {
        gradientLocations = gradientLocations.map { location in
            var newLocation = location + 0.02
            if newLocation > 1.0 {
                newLocation = 0.0
            }
            return newLocation
        }
    }
}

#Preview {
    Day7View()
}
