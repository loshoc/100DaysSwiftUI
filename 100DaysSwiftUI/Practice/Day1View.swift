//
//  Day1View.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/11.
//

import SwiftUI

struct Day1View: View {
    @State private var offset: CGFloat = -1
    
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .bold()
            .foregroundStyle(
                LinearGradient(
                    colors: [.blue, .purple, .red, .blue],
                    startPoint: UnitPoint(x: offset, y: 0),
                    endPoint: UnitPoint(x: offset + 1, y: 0)
                )
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                withAnimation(.linear(duration: 0.02)) {
                    if offset > 1 {
                        offset = -1
                    }
                    offset += 0.01
                }
            }
    }
}

#Preview {
    Day1View()
}
