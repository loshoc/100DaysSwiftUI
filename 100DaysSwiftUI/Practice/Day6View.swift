//
//  Day6View.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/16.
//

import SwiftUI

struct Day6View: View {
    
    var body: some View {
        Color.white
            .edgesIgnoringSafeArea(.all)
            .timeVaryingColorShader()
    }
}

extension View {
    func timeVaryingColorShader() -> some View {
        modifier(TimeVaryingShader())
    }
}

struct TimeVaryingShader: ViewModifier {
    
    private let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content.visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.timeVaryingColor(
                            .float2(proxy.size),
                            .float(startDate.timeIntervalSinceNow)
                        )
                    )
            }
        }
    }
}

#Preview {
    Day6View()
}
