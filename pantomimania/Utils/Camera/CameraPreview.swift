//
//  CameraPreview.swift
//  POC-photos
//
//  Created by Vinicius Rodrigues de Castro on 01/06/26.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    let sessionLayer: AVCaptureVideoPreviewLayer
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        sessionLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(sessionLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            sessionLayer.frame = uiView.bounds
        }
    }
}
