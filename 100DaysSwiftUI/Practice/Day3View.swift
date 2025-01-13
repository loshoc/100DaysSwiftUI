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
                [0.0, 0.2], [0.5, 0.2], [1.0, 0.2],
                [0.0, 0.5], [isAnimating ? 0.3 : 0.8, isAnimating ? 0.3 : 0.6], [1.0, isAnimating ? 0.6 : 0.3],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ], colors: [
                .white, .white, .white,
                .mint, Color(hex: "40E0D0"), .mint,  // Turquoise color in the middle
                Color(hex: "00BFFF"), .blue, .blue   // DeepSkyBlue to blue at bottom
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
