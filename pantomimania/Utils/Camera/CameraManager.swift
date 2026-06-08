//
//  CameraManager.swift
//  POC-photos
//
//  Created by Vinicius Rodrigues de Castro on 01/06/26.
//

import AVFoundation
import UIKit
import Combine

@Observable class CameraManager: NSObject, AVCapturePhotoCaptureDelegate {
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    var capturedImage: UIImage? // Was @Published
    
    func startSession() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output) else { return }
        
        session.beginConfiguration()
        session.addInput(input)
        session.addOutput(output)
        session.commitConfiguration()
        session.startRunning()
    }
    
    func stopSession() {
        session.stopRunning()
        
        session.beginConfiguration()
        session.inputs.forEach { session.removeInput($0)}
        session.outputs.forEach { session.removeOutput($0)}
        session.commitConfiguration()
        
        previewLayer = nil
        capturedImage = nil
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer {
        if let layer = previewLayer {
            return layer
        } else {
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.videoGravity = .resizeAspectFill
            previewLayer = layer
            return layer
        }
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraManager {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        self.capturedImage = image
    }
}
