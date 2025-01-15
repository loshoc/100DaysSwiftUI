//
//  GradientShader.metal
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/15.
//

#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

float random(float2 uv) {
    return fract(sin(dot(uv.xy, float2(12.9898, 78.233))) * 43758.5453);
}

float noise(float2 uv) {
    float2 i = floor(uv);
    float2 f = fract(uv);
    float a = random(i);
    float b = random(i + float2(1.0, 0.0));
    float c = random(i + float2(0.0, 1.0));
    float d = random(i + float2(1.0, 1.0));
    float2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

vertex VertexOut vertex_main(uint vertexID [[vertex_id]]) {
    float4 positions[4] = {
        float4(-1.0, -1.0, 0.0, 1.0),
        float4( 1.0, -1.0, 0.0, 1.0),
        float4(-1.0,  1.0, 0.0, 1.0),
        float4( 1.0,  1.0, 0.0, 1.0)
    };

    float2 uvs[4] = {
        float2(0.0, 0.0),
        float2(1.0, 0.0),
        float2(0.0, 1.0),
        float2(1.0, 1.0)
    };

    VertexOut out;
    out.position = positions[vertexID];
    out.uv = uvs[vertexID];
    return out;
}

fragment float4 noiseGradientFragment(VertexOut in [[stage_in]], constant float &time [[buffer(0)]]) {
    float gradient = in.uv.y;
    float n = noise(in.uv * 1 + float2(time * 1, time * 1));
    float colorValue = mix(gradient, n, 0.6);
    return float4(colorValue, gradient, n, 0.6);
}

