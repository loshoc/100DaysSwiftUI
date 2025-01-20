//
//  Day8View.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/20.
//

import SwiftUI

struct Day8View: View {
    @State private var isAnimating = false
    @State private var currentSymbolIndex = 0
    @State private var splashEffect = false
    
    let symbols = ["iphone", "display", "laptopcomputer", "ipad", "platter.top.applewatch.case"]
    
    var body: some View {
        ZStack {
            Color(hex: "F6F6F6") // Set the background color
                .edgesIgnoringSafeArea(.all) // Ensure it covers the entire view
            
            VStack {
                Image(systemName: symbols[currentSymbolIndex])
                    .font(.system(size: 55)) // Adjust the size as needed
                    .foregroundColor(.primary) // Adjust the color as needed
                    .symbolRenderingMode(.monochrome)
                    .offset(y: isAnimating ? -10 : 0) // Move up by 10 pixels
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isAnimating)
                    .onAppear {
                        isAnimating = true
                        Timer.scheduledTimer(withTimeInterval: 1.1, repeats: true) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                currentSymbolIndex = (currentSymbolIndex + 1) % symbols.count
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                splashEffect.toggle()
                            }
                        }
                    }
                
                Ellipse()
                    .fill(Color.black.opacity(0.2)) // Shadow color
                    .frame(width: isAnimating ? 60 : 40, height: isAnimating ? 25 : 20) // Animate width change
                    .blur(radius: 10) // Adjust blur radius as needed
                    .offset(y: -25) // Adjust vertical position as needed
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isAnimating)
                
            }
        }
    }
}

#Preview {
    Day8View()
}
