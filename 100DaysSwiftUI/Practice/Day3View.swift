//
//  Day3View.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/13.
//

import SwiftUI

struct Day3View: View {
    @State var isAnimating = false
        
    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(width: 3, height: 3, points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.7], [isAnimating ? 0.3 : 0.6, isAnimating ? 0.4 : 0.7], [1.0, isAnimating ? 0.8 : 0.4],
                [0.0, 1.0], [isAnimating ? 0.2 : 0.6, 1.0], [1.0, 1.0]
            ], colors: [
                Color(hex: "FFFDF1"), Color(hex: "FFFDF1"), Color(hex: "FFFDF1"),
                Color(hex: "6DCBA7"), Color(hex: "6DCBA7"), Color(hex: "48D6C6"),  // Turquoise color in the middle
                Color(hex: "55BFCC"), Color(hex: "84D8C8"), Color(hex: "95E2CE")   // DeepSkyBlue to blue at bottom
            ])
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                    isAnimating.toggle()
                }
            }
        } else {
            Text("MeshGradient is only available in iOS 18.0 or newer")
        }
    }
}

#Preview {
    Day3View()
}
