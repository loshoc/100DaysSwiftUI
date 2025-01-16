//
//  Color.metal
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/16.
//

#include <metal_stdlib>
using namespace metal;

float oscillate(float f) {
    return 0.5 * (sin(f) + 1);
}
[[ stitchable ]]
half4 timeVaryingColor(float2 position, half4 color, float2 size, float time) {
    return half4(0.0, oscillate(10*time + (2 * M_PI_F * position.x / size.x)), 0.0, 1.0);
}
