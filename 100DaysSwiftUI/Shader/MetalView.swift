//
//  MetalView.swift
//  100DaysSwiftUI
//
//  Created by Kiwi Guo on 2025/1/15.
//
import SwiftUI
import MetalKit

struct MetalView: UIViewRepresentable {
    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.enableSetNeedsDisplay = false
        mtkView.isPaused = false
        return mtkView
    }

    func updateUIView(_ uiView: MTKView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MTKViewDelegate {
        var device: MTLDevice?
        var pipelineState: MTLRenderPipelineState?
        var vertexBuffer: MTLBuffer?
        var timeBuffer: MTLBuffer?

        override init() {
            super.init()
            self.device = MTLCreateSystemDefaultDevice()

            if MTLCreateSystemDefaultDevice() == nil {
                print("Metal is not supported on this device")
            }

            guard let device = self.device else {
                print("Metal is not supported on this device")
                return
            }

            do {
                let library = try device.makeDefaultLibrary(bundle: .main)
                guard let fragmentFunction = library.makeFunction(name: "noiseGradientFragment"),
                      let vertexFunction = library.makeFunction(name: "vertex_main") else {
                    print("Failed to load shader functions")
                    return
                }

                let pipelineDescriptor = MTLRenderPipelineDescriptor()
                pipelineDescriptor.vertexFunction = vertexFunction
                pipelineDescriptor.fragmentFunction = fragmentFunction
                pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

                self.pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)

                // Create vertex buffer
                let vertices: [Float] = [
                    -1.0, -1.0, 0.0, 1.0,
                     1.0, -1.0, 0.0, 1.0,
                    -1.0,  1.0, 0.0, 1.0,
                     1.0,  1.0, 0.0, 1.0
                ]
                self.vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])

                // Create a buffer for time
                var time: Float = Float(CACurrentMediaTime())
                self.timeBuffer = device.makeBuffer(bytes: &time, length: MemoryLayout<Float>.size, options: [])
            } catch {
                print("Error creating pipeline state: \(error)")
            }
        }

        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

        func draw(in view: MTKView) {
            guard let drawable = view.currentDrawable,
                  let renderPassDescriptor = view.currentRenderPassDescriptor,
                  let pipelineState = self.pipelineState,
                  let commandQueue = device?.makeCommandQueue(),
                  let commandBuffer = commandQueue.makeCommandBuffer(),
                  let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor),
                  let vertexBuffer = self.vertexBuffer,
                  let device = self.device else {
                return
            }

            // Update time buffer
            var time: Float = Float(CACurrentMediaTime())
            self.timeBuffer = device.makeBuffer(bytes: &time, length: MemoryLayout<Float>.size, options: [])

            renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0) // Black background

            renderEncoder.setRenderPipelineState(pipelineState)
            renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            renderEncoder.setFragmentBuffer(timeBuffer, offset: 0, index: 0)
            renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
            renderEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
